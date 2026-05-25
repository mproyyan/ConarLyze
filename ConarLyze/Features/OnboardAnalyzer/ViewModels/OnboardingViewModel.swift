    //
    //  OnboardingViewModel.swift
    //  ConarLyze
    //
    //  Created by Ahmad Zaki on 25/05/26.
    //

    import SwiftUI
    internal import Combine

    @MainActor
    final class OnboardingViewModel: ObservableObject {

        enum Step {
            case welcome
            case introduction
            case tutorial
            case camera
            case analyzing
        }

        // MARK: - Navigation State

        @Published var currentStep: Step

        init(initialStep: Step = .welcome) {
            self.currentStep = initialStep
        }

        // MARK: - User Input

        @Published var userName: String = ""
        @Published var selectedGender: IntroductionView.Gender?

        // MARK: - Loading State

        @Published var isAnalyzing: Bool = false
        @Published var errorMessage: String?

        // MARK: - App State

        @AppStorage("hasCompletedOnboarding")
        var hasCompletedOnboarding: Bool = false

        // MARK: - Navigation Actions

        func goToIntroduction() {
            currentStep = .introduction
        }

        func goToTutorial() {
            currentStep = .tutorial
        }

        func goToCamera() {
            currentStep = .camera
        }

        // MARK: - Analyze Flow

        func analyzeColor(from imageURL: URL?) async {

            guard let imageURL else {
                errorMessage = "Image not found"
                return
            }

            currentStep = .analyzing
            isAnalyzing = true

            do {

                // TODO:
                // Call analyzeColor API here

                print("Analyzing image:", imageURL)

                // Simulate API loading
                try await Task.sleep(for: .seconds(3))

                // TODO:
                // Save response using LocalStateRepository

                // Success
                hasCompletedOnboarding = true

            } catch {

                errorMessage = error.localizedDescription

            }

            isAnalyzing = false
        }
    }
