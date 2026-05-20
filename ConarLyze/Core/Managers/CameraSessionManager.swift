//
//  CameraSessionManager.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//

import AVFoundation
import UIKit
internal import Combine
 
// MARK: - Permission State
 
enum CameraPermissionState {
    case notDetermined
    case authorized
    case denied
}
 
// MARK: - Camera Error
 
enum CameraError: LocalizedError {
    case deviceUnavailable
    case inputSetupFailed
    case outputSetupFailed
    case captureFailed(String)
    case saveFailed(String)
 
    var errorDescription: String? {
        switch self {
        case .deviceUnavailable:       return "Front camera is not available on this device."
        case .inputSetupFailed:        return "Failed to configure camera input."
        case .outputSetupFailed:       return "Failed to configure photo output."
        case .captureFailed(let msg):  return "Photo capture failed: \(msg)"
        case .saveFailed(let msg):     return "Could not save photo: \(msg)"
        }
    }
}
 
// MARK: - CameraSessionManager
 
/// Manages the full lifecycle of an `AVCaptureSession`.
/// Runs session configuration and start/stop on a private serial queue.
/// Publishes state changes on the **main thread** for the ViewModel to observe.
final class CameraSessionManager: NSObject {
 
    // MARK: Public properties
 
    /// The session that `CameraPreviewView` binds to.
    let session = AVCaptureSession()
 
    // MARK: Combine subjects (published on main thread)
 
    let permissionState  = CurrentValueSubject<CameraPermissionState, Never>(.notDetermined)
    let isSessionRunning = CurrentValueSubject<Bool, Never>(false)
    let capturedImageURL = PassthroughSubject<URL, Never>()
    let errorSubject     = PassthroughSubject<CameraError, Never>()
 
    // MARK: Private
 
    private let sessionQueue = DispatchQueue(label: "com.camera.sessionQueue", qos: .userInitiated)
    private var photoOutput  = AVCapturePhotoOutput()
    private var isConfigured = false
 
    // MARK: - Permission
 
    func requestPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            publish(permission: .authorized)
            configureSessionIfNeeded()
 
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self else { return }
                self.publish(permission: granted ? .authorized : .denied)
                if granted { self.configureSessionIfNeeded() }
            }
 
        default:
            publish(permission: .denied)
        }
    }
 
    // MARK: - Session Lifecycle
 
    func startSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            guard self.isConfigured else { return }
            if !self.session.isRunning {
                self.session.startRunning()
                DispatchQueue.main.async { self.isSessionRunning.send(true) }
            }
        }
    }
 
    func stopSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            if self.session.isRunning {
                self.session.stopRunning()
                DispatchQueue.main.async { self.isSessionRunning.send(false) }
            }
        }
    }
 
    // MARK: - Photo Capture
 
    func capturePhoto() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            let settings = AVCapturePhotoSettings()
            // Use HEIF when available for smaller file sizes
            if self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                let heifSettings = AVCapturePhotoSettings(
                    format: [AVVideoCodecKey: AVVideoCodecType.hevc]
                )
                self.photoOutput.capturePhoto(with: heifSettings, delegate: self)
            } else {
                self.photoOutput.capturePhoto(with: settings, delegate: self)
            }
        }
    }
 
    // MARK: - Private helpers
 
    // MARK: - Device selection
 
    /// Returns the best available capture device, gracefully degrading on the simulator.
    private func bestAvailableCamera() -> AVCaptureDevice? {
        // 1. Front wide-angle — standard on all modern iPhones
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            return device
        }
        // 2. Any front-facing camera
        if let device = AVCaptureDevice.default(for: .video),
           device.position == .front {
            return device
        }
        // 3. Back wide-angle — available on simulator & devices without a front camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return device
        }
        // 4. Absolute last resort: whatever the system gives us
        return AVCaptureDevice.default(for: .video)
    }
 
    private func configureSessionIfNeeded() {
        sessionQueue.async { [weak self] in
            guard let self, !self.isConfigured else { return }
            self.configureSession()
        }
    }
 
    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
 
        // ── Input ──────────────────────────────────────────────────────────
        // Priority order:
        //   1. Front wide-angle (real device)
        //   2. Any front camera (real device fallback)
        //   3. Any back camera (simulator — has no front camera)
        //   4. Any video device (last resort)
        guard let device = bestAvailableCamera() else {
            session.commitConfiguration()
            publish(error: .deviceUnavailable)
            return
        }
 
        do {
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input) else {
                session.commitConfiguration()
                publish(error: .inputSetupFailed)
                return
            }
            session.addInput(input)
        } catch {
            session.commitConfiguration()
            publish(error: .inputSetupFailed)
            return
        }
 
        // ── Output ─────────────────────────────────────────────────────────
        photoOutput = AVCapturePhotoOutput()
        guard session.canAddOutput(photoOutput) else {
            session.commitConfiguration()
            publish(error: .outputSetupFailed)
            return
        }
        session.addOutput(photoOutput)
        photoOutput.isHighResolutionCaptureEnabled = true
 
        session.commitConfiguration()
        isConfigured = true
 
        // Start immediately after configuration
        session.startRunning()
        DispatchQueue.main.async { self.isSessionRunning.send(true) }
    }
 
    // MARK: - Thread-safe publish helpers
 
    private func publish(permission: CameraPermissionState) {
        DispatchQueue.main.async { self.permissionState.send(permission) }
    }
 
    private func publish(error: CameraError) {
        DispatchQueue.main.async { self.errorSubject.send(error) }
    }
}
 
// MARK: - AVCapturePhotoCaptureDelegate
 
extension CameraSessionManager: AVCapturePhotoCaptureDelegate {
 
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        if let error {
            publish(error: .captureFailed(error.localizedDescription))
            return
        }
 
        guard let data = photo.fileDataRepresentation() else {
            publish(error: .captureFailed("No data in captured photo."))
            return
        }
 
        // Save to Documents directory on a background thread
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self else { return }
            do {
                let url = try self.savePhoto(data: data)
                DispatchQueue.main.async { self.capturedImageURL.send(url) }
            } catch {
                self.publish(error: .saveFailed(error.localizedDescription))
            }
        }
    }
 
    // MARK: - File I/O
 
    private func savePhoto(data: Data) throws -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filename  = "capture_\(UUID().uuidString).jpg"
        let fileURL   = documents.appendingPathComponent(filename)
 
        // Convert to JPEG for broad compatibility when saving
        guard
            let image   = UIImage(data: data),
            let jpegData = image.jpegData(compressionQuality: 0.92)
        else {
            throw CameraError.saveFailed("Failed to encode image as JPEG.")
        }
 
        try jpegData.write(to: fileURL, options: .atomic)
        return fileURL
    }
}
