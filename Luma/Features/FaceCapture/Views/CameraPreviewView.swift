//
//  CameraPreviewView.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//

import SwiftUI
import AVFoundation
 
// MARK: - Preview UIView Subclass
 
/// A UIView subclass that uses AVCaptureVideoPreviewLayer as its backing layer.
/// This is the key to avoiding the blank/white screen issue — by making the
/// preview layer the view's own layer, it always matches the view's bounds.
final class PreviewUIView: UIView {
 
    // Override layerClass so UIKit uses AVCaptureVideoPreviewLayer as the backing layer
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
 
    /// Typed accessor for the backing layer
    var previewLayer: AVCaptureVideoPreviewLayer {
        // swiftlint:disable:next force_cast
        layer as! AVCaptureVideoPreviewLayer
    }
 
    /// Called whenever the view's bounds change (rotation, layout pass, etc.)
    override func layoutSubviews() {
        super.layoutSubviews()
        // Keep the preview layer frame in sync with the view's bounds
        previewLayer.frame = bounds
    }
}
 
// MARK: - CameraPreviewView (UIViewRepresentable)
 
/// SwiftUI wrapper around `PreviewUIView`.
/// Connects the `AVCaptureSession` to the preview layer once the view is created.
struct CameraPreviewView: UIViewRepresentable {
 
    /// The session managed by `CameraSessionManager`
    let session: AVCaptureSession
 
    // MARK: UIViewRepresentable
 
    func makeUIView(context: Context) -> PreviewUIView {
        let view = PreviewUIView()
        view.backgroundColor = .black
 
        let layer = view.previewLayer
        layer.session = session
        layer.videoGravity = .resizeAspectFill
        if let connection = layer.connection {
            if #available(iOS 17.0, *) {
                // 0 degrees corresponds to portrait orientation
                connection.videoRotationAngle = 0
            } else {
                connection.videoOrientation = .portrait
            }
        }
 
        return view
    }
 
    func updateUIView(_ uiView: PreviewUIView, context: Context) {
        // Ensure the session reference stays current if it ever changes
        uiView.previewLayer.session = session
        uiView.previewLayer.frame = uiView.bounds
        if let connection = uiView.previewLayer.connection {
            if #available(iOS 17.0, *) {
                connection.videoRotationAngle = 0
            } else {
                connection.videoOrientation = .portrait
            }
        }
    }
}

