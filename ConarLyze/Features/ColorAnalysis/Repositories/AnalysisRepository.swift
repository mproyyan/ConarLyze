//
//  AnalysisRepository.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

protocol AnalysisRepositoryProtocol {
    func analyzeColor(imageData: Data) async throws -> ColorAnalysisResult
    func getSavedAnalysisResult() -> ColorAnalysisResult?
    func clearSavedAnalysisResult()
}

final class AnalysisRepository: AnalysisRepositoryProtocol {
    private let apiClient: APIClient
    private let localStateRepository: LocalStateRepositoryProtocol
    
    init(
        apiClient: APIClient = .shared,
        localStateRepository: LocalStateRepositoryProtocol = LocalStateRepository.shared
    ) {
        self.apiClient = apiClient
        self.localStateRepository = localStateRepository
    }
    
    func analyzeColor(imageData: Data) async throws -> ColorAnalysisResult {
        let responseDTO: ColorAnalysisResponseDTO = try await apiClient.uploadMultipart(
            endpoint: APIConfig.analyzeColor,
            imageData: imageData,
            fieldName: "image",
            fileName: "photo.jpg",
            mimeType: "image/jpeg"
        )
        
        let result = responseDTO.toDomain()
        
        localStateRepository.saveAnalysisResult(result)
        
        return result
    }
    
    func getSavedAnalysisResult() -> ColorAnalysisResult? {
        localStateRepository.loadAnalysisResult(as: ColorAnalysisResult.self)
    }
    
    func clearSavedAnalysisResult() {
        localStateRepository.clearAnalysisResult()
    }
}
