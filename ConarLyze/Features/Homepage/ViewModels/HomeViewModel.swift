//
//  HomeViewModel.swift
//  ConarLyze
//

import Foundation
internal import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published var userName: String = "User"
    @Published var analysisResult: ColorAnalysisResult?
    @Published var userPhoto: Data?
    @Published var ideas: [FashionIdeaModel] = FashionIdeaModel.dummy
    
    // MARK: - Dependencies
    
    private let localStateRepository: LocalStateRepositoryProtocol
    
    // MARK: - Init
    
    init(
        localStateRepository: LocalStateRepositoryProtocol = LocalStateRepository.shared
    ) {
        self.localStateRepository = localStateRepository
        loadLocalData()
    }
    
    // MARK: - Load Data
    
    func loadLocalData() {
        let profile = localStateRepository.loadUserProfile()
        
        if let name = profile?.name, !name.isEmpty {
            userName = name
        } else {
            userName = "User"
        }
        
        analysisResult = localStateRepository.loadAnalysisResult(
            as: ColorAnalysisResult.self
        )
        
        userPhoto = localStateRepository.loadUserPhoto()
    }
}
