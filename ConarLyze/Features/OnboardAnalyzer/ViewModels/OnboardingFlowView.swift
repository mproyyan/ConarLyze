//
//  OnboardingFlowView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 25/05/26.
//

import SwiftUI

struct OnboardingFlowView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    init(initialStep: OnboardingViewModel.Step = .welcome) {
        _viewModel = StateObject(
            wrappedValue: OnboardingViewModel(initialStep: initialStep)
        )
    }

    var body: some View {
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
                Task {
                    await viewModel.analyzeColor(from: imageURL)
                }
            }
        case .analyzing:
            AnalyzingLoadingView()
        }
    }
}
