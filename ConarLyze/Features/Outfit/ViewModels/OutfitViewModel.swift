//
//  OutfitViewModel.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation
internal import Combine

@MainActor
final class OutfitViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published var recommendedOutfits: [RecommendedOutfit] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    
    private let outfitRepository: OutfitRepositoryProtocol
    
    // MARK: - Init
    
    init(
        outfitRepository: OutfitRepositoryProtocol = OutfitRepository()
    ) {
        self.outfitRepository = outfitRepository
    }
    
    // MARK: - Load Outfit Recommendations
    
    func loadRecommendations(
        bestColors: [AppColorRecommendation],
        avoidColors: [AppColorRecommendation],
        gender: String
    ) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let outfits = try await outfitRepository.getRecommendations(
                bestColors: bestColors,
                avoidColors: avoidColors,
                gender: gender
            )
            
            self.recommendedOutfits = outfits
            self.isLoading = false
            
        } catch {
            print("Failed to load outfit recommendations:", error)
            print("Localized error:", error.localizedDescription)
            
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
