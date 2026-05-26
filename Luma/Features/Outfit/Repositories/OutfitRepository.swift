//
//  OutfitRepository.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

protocol OutfitRepositoryProtocol {
    func getRecommendations(
        bestColors: [AppColorRecommendation],
        avoidColors: [AppColorRecommendation],
        gender: String
    ) async throws -> [RecommendedOutfit]
    
    func pickColorSeason(type: String) async throws -> ColorAnalysisResponse
}


final class OutfitRepository: OutfitRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func getRecommendations(
        bestColors: [AppColorRecommendation],
        avoidColors: [AppColorRecommendation],
        gender: String
    ) async throws -> [RecommendedOutfit] {
        
        let requestDTO = RecommendationRequestDTO(
            bestColors: bestColors.map { $0.hex },
            avoidColors: avoidColors.map { $0.hex },
            gender: gender
        )
        
        let bodyData = try JSONEncoder().encode(requestDTO)
        
        let responseDTO: RecommendationResponseDTO = try await apiClient.request(
            endpoint: APIConfig.recommendOutfit + "?minScore=51",
            method: .post,
            body: bodyData,
            headers: [
                "Content-Type": "application/json"
            ]
        )
        
        let outfits = responseDTO.results.map { resultDTO in
            resultDTO.toDomain()
        }
        
        return outfits
    }
    
    func pickColorSeason(type: String) async throws -> ColorAnalysisResponse {
            guard let encodedType = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                throw URLError(.badURL)
            }
            
            let endpointWithQuery = APIConfig.pickColor + "?type=\(encodedType)"
            
            let analysisResponse: ColorAnalysisResponse = try await apiClient.request(
                endpoint: endpointWithQuery,
                method: .get,
                body: nil,
                headers: [
                    "Content-Type": "application/json"
                ]
            )
            
            return analysisResponse
        }
    
}
