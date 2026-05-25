//
//  DIContainer.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation
internal import Combine

@MainActor
final class DIContainer: ObservableObject {
    
    // MARK: - Core Dependencies
    
    let apiClient: APIClient
    let localStateRepository: LocalStateRepositoryProtocol
    
    // MARK: - Feature Repositories
    
    let analysisRepository: AnalysisRepositoryProtocol
    let outfitRepository: OutfitRepositoryProtocol
    
    // MARK: - Init
    
    init() {
        self.apiClient = APIClient.shared
        self.localStateRepository = LocalStateRepository.shared
        
        self.analysisRepository = AnalysisRepository(
            apiClient: APIClient.shared,
            localStateRepository: LocalStateRepository.shared
        )
        
        self.outfitRepository = OutfitRepository(
            apiClient: APIClient.shared
        )
    }
    
    init(
        apiClient: APIClient,
        localStateRepository: LocalStateRepositoryProtocol,
        analysisRepository: AnalysisRepositoryProtocol,
        outfitRepository: OutfitRepositoryProtocol
    ) {
        self.apiClient = apiClient
        self.localStateRepository = localStateRepository
        self.analysisRepository = analysisRepository
        self.outfitRepository = outfitRepository
    }
}
