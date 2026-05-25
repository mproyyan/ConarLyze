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
    
    // MARK: - Init
    
    init() {
        self.apiClient = APIClient.shared
        self.localStateRepository = LocalStateRepository.shared
    }
    
    init(
        apiClient: APIClient,
        localStateRepository: LocalStateRepositoryProtocol
    ) {
        self.apiClient = apiClient
        self.localStateRepository = localStateRepository
    }
}
