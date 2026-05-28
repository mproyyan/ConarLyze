//
//  CameraView.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//

import SwiftUI
import AVFoundation

// MARK: - CameraView

struct CameraView: View {
    var onBack: (() -> Void)? = nil
    let onPhotoCaptured: (URL?) -> Void
    
    @StateObject private var viewModel = CameraViewModel()
    
    // Geometry-driven constants
    // Scaled up so user doesn't have to reach out too far
    private let guideSize = CGSize(width: 280, height: 360)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                cameraPreviewLayer
                
                overlayWithCutout(in: geo.size)
                
                instructionLabel(in: geo.size)
                
                VStack {
                    topBar
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    bottomControls
                }
                
                if viewModel.showCaptureSuccess {
                    successToast
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                if viewModel.permissionState != .authorized {
                    permissionPlaceholder
                }
            }
            .ignoresSafeArea()
            .overlay(
                Color.white
                    .opacity(viewModel.isCapturing ? 0.55 : 0)
                    .ignoresSafeArea()
                    .animation(.easeOut(duration: 0.25), value: viewModel.isCapturing)
            )
        }
        .task {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.capturedImageURL) { _, newValue in
            guard let newValue else {
                return
            }
            
            onPhotoCaptured(newValue)
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .alert(item: $viewModel.alertItem) { item in
            if let action = item.primaryAction {
                return Alert(
                    title: Text(item.title),
                    message: Text(item.message),
                    primaryButton: .default(
                        Text(item.primaryButtonTitle),
                        action: action
                    ),
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(
                    title: Text(item.title),
                    message: Text(item.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Sub-views
    
    @ViewBuilder
    private var cameraPreviewLayer: some View {
        if viewModel.permissionState == .authorized {
            CameraPreviewView(
                session: viewModel.sessionManager.session
            )
            .ignoresSafeArea()
        } else {
            Color.black
                .ignoresSafeArea()
        }
    }
    
    /// Builds the semi-transparent dark overlay with a transparent face cutout
    /// using an inverted mask.
    private func overlayWithCutout(in size: CGSize) -> some View {
        let center = CGPoint(
            x: size.width / 2,
            y: size.height * 0.42
        )
        
        let guideRect = CGRect(
            x: center.x - guideSize.width / 2,
            y: center.y - guideSize.height / 2,
            width: guideSize.width,
            height: guideSize.height
        )
        
        return Rectangle()
            .fill(Color.black.opacity(0.55))
            .ignoresSafeArea()
            .mask(
                CutoutMask(cutoutRect: guideRect)
                    .fill(style: FillStyle(eoFill: true))
                    .ignoresSafeArea()
            )
    }
    
    /// Positions the instruction label directly above the cutout shape.
    private func instructionLabel(in size: CGSize) -> some View {
        let cutoutTopY = (size.height * 0.42) - (guideSize.height / 2)
        
        return Text("Position your face within the frame")
            .font(.system(size: 13, weight: .medium, design: .rounded))
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial, in: Capsule())
            .position(
                x: size.width / 2,
                y: cutoutTopY - 35
            )
    }
    
    private var topBar: some View {
        ZStack {
            Text("Face Capture")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            HStack {
                if let onBack = onBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
        }
        .padding(.top, 60)
        .padding(.horizontal, 20)
    }
    
    private var bottomControls: some View {
        VStack(spacing: 20) {
            
            // MARK: - Thumbnail of Last Capture
            
            if let url = viewModel.capturedImageURL,
               let uiImage = UIImage(contentsOfFile: url.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(
                                .white.opacity(0.5),
                                lineWidth: 1.5
                            )
                    )
                    .transition(.scale.combined(with: .opacity))
            }
            
            // MARK: - Capture Button
            
            CaptureButton(isCapturing: viewModel.isCapturing) {
                viewModel.capturePhoto()
            }
            .disabled(!viewModel.isSessionRunning || viewModel.isCapturing)
            
            Spacer()
                .frame(height: 30)
        }
        .padding(.bottom, 10)
    }
    
    private var successToast: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                
                Text("Photo saved successfully")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.top, 60)
            
            Spacer()
        }
    }
    
    private var permissionPlaceholder: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(systemName: isSimulator ? "iphone.slash" : "camera.slash.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.white.opacity(0.5))
                
                Text(placeholderMessage)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
    
    private var placeholderMessage: String {
        if isSimulator {
            return "Running on Simulator\nNo real camera available.\nRun on a physical device to use the camera."
        }
        
        switch viewModel.permissionState {
        case .denied:
            return "Camera access is disabled.\nEnable it in Settings → Privacy → Camera."
            
        case .notDetermined:
            return "Requesting camera access…"
            
        case .authorized:
            return "Starting camera…"
        }
    }
    
    /// True when running inside the Xcode Simulator.
    private var isSimulator: Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
}

// MARK: - CutoutMask Shape

private struct CutoutMask: Shape {
    let cutoutRect: CGRect
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(rect)
        
        let faceShape = FaceGuideShape()
        let localFaceBounds = CGRect(
            origin: .zero,
            size: cutoutRect.size
        )
        
        var facePath = faceShape.path(in: localFaceBounds)
        
        let translation = CGAffineTransform(
            translationX: cutoutRect.origin.x,
            y: cutoutRect.origin.y
        )
        
        facePath = facePath.applying(translation)
        path.addPath(facePath)
        
        return path
    }
}

// MARK: - CaptureButton

private struct CaptureButton: View {
    let isCapturing: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .strokeBorder(.white, lineWidth: 3)
                    .frame(width: 76, height: 76)
                
                Circle()
                    .fill(.white)
                    .frame(width: 60, height: 60)
                    .scaleEffect(isCapturing ? 0.82 : 1.0)
                    .animation(
                        .spring(response: 0.25, dampingFraction: 0.6),
                        value: isCapturing
                    )
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Face Guide Shape

struct FaceGuideShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: 0))
        
        path.addCurve(
            to: CGPoint(x: width * 0.9, y: height * 0.4),
            control1: CGPoint(x: width * 0.75, y: 0),
            control2: CGPoint(x: width * 0.9, y: height * 0.15)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.63, y: height * 0.98),
            control1: CGPoint(x: width * 0.9, y: height * 0.65),
            control2: CGPoint(x: width * 0.75, y: height * 0.92)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.37, y: height * 0.98),
            control1: CGPoint(x: width * 0.54, y: height * 1.01),
            control2: CGPoint(x: width * 0.46, y: height * 1.01)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.1, y: height * 0.4),
            control1: CGPoint(x: width * 0.25, y: height * 0.92),
            control2: CGPoint(x: width * 0.1, y: height * 0.65)
        )
        
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: 0),
            control1: CGPoint(x: width * 0.1, y: height * 0.15),
            control2: CGPoint(x: width * 0.25, y: 0)
        )
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview

#Preview {
    CameraView(onPhotoCaptured: { _ in })
}
