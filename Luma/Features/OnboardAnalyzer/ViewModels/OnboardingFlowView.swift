//
//  OnboardingFlowView.swift
//  Luma
//
//  Created by Ahmad Zaki on 25/05/26.
//

import SwiftUI
import UIKit

struct OnboardingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: OnboardingViewModel

    private let dismissOnCompletion: Bool
    private let onCompletion: (() async -> Void)?

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding: Bool = false

    init(
        initialStep: OnboardingViewModel.Step = .welcome,
        dismissOnCompletion: Bool = false,
        onCompletion: (() async -> Void)? = nil
    ) {
        _viewModel = StateObject(
            wrappedValue: OnboardingViewModel(initialStep: initialStep)
        )
        self.dismissOnCompletion = dismissOnCompletion
        self.onCompletion = onCompletion
    }

    var body: some View {
        ZStack {
            switch viewModel.currentStep {
            case .welcome:
                WelcomeView {
                    viewModel.goToIntroduction()
                }

            case .introduction:
                IntroductionView(
                    name: $viewModel.userName,
                    selectedGender: $viewModel.selectedGender
                ) {
                    viewModel.goToTutorial()
                }

            case .tutorial:
                TutorialView {
                    viewModel.goToIntroduction()
                } onNext: {
                    viewModel.goToCamera()
                }

            case .camera:
                CameraView { imageURL in
                    guard let imageURL = imageURL else {
                        viewModel.errorMessage = "Failed to capture image."
                        return
                    }

                    do {
                        let rawImageData = try Data(contentsOf: imageURL)

                        guard let image = UIImage(data: rawImageData) else {
                            viewModel.errorMessage = "Failed to process captured image."
                            return
                        }

                        let resizedImage = image.resized(maxDimension: 1024)

                        guard let compressedData = resizedImage.jpegData(compressionQuality: 0.6) else {
                            viewModel.errorMessage = "Failed to compress captured image."
                            return
                        }

                        print("Raw image size:", formatBytes(rawImageData.count))
                        print("Compressed image size:", formatBytes(compressedData.count))

                        Task {
                            await viewModel.analyzeCapturedImage(compressedData)
                        }
                    } catch {
                        viewModel.errorMessage = "Failed to read captured image file."
                    }
                }

            case .analyzing:
                AnalyzingLoadingView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: viewModel.didCompleteOnboarding) { _, didComplete in
            guard didComplete else { return }

            hasCompletedOnboarding = true

            Task {
                await onCompletion?()

                if dismissOnCompletion {
                    dismiss()
                }
            }
        }
        .alert("Analysis Failed", isPresented: errorAlertBinding) {
            Button("Try Again") {
                viewModel.errorMessage = nil
                viewModel.goToCamera()
            }
        } message: {
            Text(viewModel.errorMessage ?? "Something went wrong.")
        }
    }

    // MARK: - Error Alert Binding

    private var errorAlertBinding: Binding<Bool> {
        Binding(
            get: {
                viewModel.errorMessage != nil
            },
            set: { newValue in
                if newValue == false {
                    viewModel.errorMessage = nil
                }
            }
        )
    }

    // MARK: - Helper

    private func formatBytes(_ bytes: Int) -> String {
        let mb = Double(bytes) / 1024 / 1024
        return String(format: "%.2f MB", mb)
    }
}

// MARK: - UIImage Resize Helper

private extension UIImage {
    func resized(maxDimension: CGFloat) -> UIImage {
        let originalWidth = size.width
        let originalHeight = size.height

        let maxOriginalDimension = max(originalWidth, originalHeight)

        guard maxOriginalDimension > maxDimension else {
            return self
        }

        let scale = maxDimension / maxOriginalDimension
        let newWidth = originalWidth * scale
        let newHeight = originalHeight * scale
        let newSize = CGSize(width: newWidth, height: newHeight)

        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
