//
//  OnboardingViewModel.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 25/05/26.
//

import Foundation
internal import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    
    // MARK: - Step
    
    enum Step {
        case welcome
        case introduction
        case tutorial
        case camera
        case analyzing
    }
    
    // MARK: - Published Flow State
    
    @Published var currentStep: Step = .welcome
    @Published var userName: String = ""
    @Published var selectedGender: IntroductionView.Gender? = nil
    
    // MARK: - Published API State
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var analysisResult: ColorAnalysisResult?
    @Published var didCompleteOnboarding: Bool = false
    
    // MARK: - Dependencies
    
    private let analysisRepository: AnalysisRepositoryProtocol
    private let localStateRepository: LocalStateRepositoryProtocol
    
    // MARK: - Init
    
    init(
        initialStep: Step = .welcome,
        analysisRepository: AnalysisRepositoryProtocol = AnalysisRepository(
            apiClient: APIClient.shared,
            localStateRepository: LocalStateRepository.shared
        ),
        localStateRepository: LocalStateRepositoryProtocol = LocalStateRepository.shared
    ) {
        self.currentStep = initialStep
        self.analysisRepository = analysisRepository
        self.localStateRepository = localStateRepository
    }
    
    // MARK: - Flow Actions
    
    func goToIntroduction() {
        currentStep = .introduction
    }
    
    func goToTutorial() {
        currentStep = .tutorial
    }
    
    func goToCamera() {
        currentStep = .camera
    }
    
    func goToAnalyzing() {
        currentStep = .analyzing
    }
    
    func goBackToWelcome() {
        currentStep = .welcome
    }
    
    // MARK: - Analyze Image
    
    func analyzeCapturedImage(_ imageData: Data) async {
        isLoading = true
        errorMessage = nil
        currentStep = .analyzing
        
        do {
            let result = try await analysisRepository.analyzeColor(imageData: imageData)
            
            analysisResult = result
            
            try localStateRepository.saveAnalysisResult(result)
            
            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
            
            didCompleteOnboarding = true
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
