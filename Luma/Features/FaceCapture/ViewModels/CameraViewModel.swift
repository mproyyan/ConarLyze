//
//  CameraViewModel.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//


import SwiftUI
internal import Combine
 
// MARK: - CameraViewModel
 
@MainActor
final class CameraViewModel: ObservableObject {
 
    // MARK: Published state
 
    @Published var permissionState: CameraPermissionState = .notDetermined
    @Published var isSessionRunning: Bool  = false
    @Published var isCapturing: Bool       = false   // shutter animation flag
    @Published var capturedImageURL: URL?  = nil
    @Published var showCaptureSuccess: Bool = false
 
    // Alert state
    @Published var alertItem: AlertItem?
 
    // MARK: Session manager (owned here, shared with the view for the preview)
 
    let sessionManager = CameraSessionManager()
 
    // MARK: Private
 
    private var cancellables = Set<AnyCancellable>()
 
    // MARK: - Init
 
    init() {
        bindSessionManager()
    }
 
    // MARK: - Public API
 
    /// Call from `.onAppear` / `.task` in the View
    func onAppear() {
        sessionManager.requestPermission()
    }
 
    /// Call from `.onDisappear` in the View
    func onDisappear() {
        sessionManager.stopSession()
    }
 
    /// Triggered by the capture button
    func capturePhoto() {
        guard !isCapturing else { return }
        isCapturing = true
 
        // Provide haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
 
        sessionManager.capturePhoto()
 
        // Reset the shutter animation flag after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.isCapturing = false
        }
    }
 
    // MARK: - Private
 
    private func bindSessionManager() {
        sessionManager.permissionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                self.permissionState = state
                if state == .authorized {
                    self.sessionManager.startSession()
                } else if state == .denied {
                    self.alertItem = AlertItem(
                        title: "Camera Access Required",
                        message: "Please enable camera access in Settings → Privacy → Camera to use this feature.",
                        primaryButtonTitle: "Open Settings",
                        primaryAction: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                }
            }
            .store(in: &cancellables)
 
        sessionManager.isSessionRunning
            .receive(on: DispatchQueue.main)
            .assign(to: &$isSessionRunning)
 
        sessionManager.capturedImageURL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                guard let self else { return }
                self.capturedImageURL = url
                self.showCaptureSuccess = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.showCaptureSuccess = false
                }
            }
            .store(in: &cancellables)
 
        sessionManager.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                self.alertItem = AlertItem(
                    title: "Camera Error",
                    message: error.localizedDescription
                )
            }
            .store(in: &cancellables)
    }
}
 
// MARK: - AlertItem helper
 
struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    var primaryButtonTitle: String = "OK"
    var primaryAction: (() -> Void)? = nil
}
