//
//  OnboardingFlowView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 25/05/26.
//

import SwiftUI

struct OnboardingFlowView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding: Bool = false
    
    init(initialStep: OnboardingViewModel.Step = .welcome) {
        _viewModel = StateObject(
            wrappedValue: OnboardingViewModel(initialStep: initialStep)
        )
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
                    viewModel.goToCamera()
                }
                
            case .camera:
                CameraView { imageURL in
                    guard let imageURL = imageURL else {
                        viewModel.errorMessage = "Failed to capture image."
                        return
                    }
                    
                    Task {
                        await analyzeImage(from: imageURL)
                    }
                }
                
            case .analyzing:
                AnalyzingLoadingView()
            }
        }
        .onChange(of: viewModel.didCompleteOnboarding) { _, didComplete in
            if didComplete {
                hasCompletedOnboarding = true
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
    
    // MARK: - Analyze Image
    
    private func analyzeImage(from imageURL: URL) async {
        do {
            let imageData = try Data(contentsOf: imageURL)
            await viewModel.analyzeCapturedImage(imageData)
        } catch {
            viewModel.errorMessage = "Failed to read captured image."
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
}
