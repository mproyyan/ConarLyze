//
//  RecommendationDTO.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct RecommendationRequestDTO: Codable {
    let bestColors: [String]
    let avoidColors: [String]
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case bestColors = "best_colors"
        case avoidColors = "avoid_colors"
        case gender
    }
}

struct RecommendationResponseDTO: Codable {
    let results: [RecommendationResultDTO]
    let total: Int
    let filters: RecommendationFiltersDTO?
}

struct RecommendationResultDTO: Codable, Identifiable {
    var id: String {
        outfit.id
    }
    
    let outfit: OutfitDTO
    let score: Double
    let bestTotal: Double
    let avoidTotal: Double
    let coherence: Double
    let itemScores: [ItemScoreDTO]
    let reasons: [String]
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case outfit
        case score
        case bestTotal = "best_total"
        case avoidTotal = "avoid_total"
        case coherence
        case itemScores = "item_scores"
        case reasons
        case rank
    }
}

struct ItemScoreDTO: Codable, Identifiable {
    var id: String {
        key
    }
    
    let key: String
    let name: String
    let color: String
    let hex: String
    let weight: Double
    let bestDeltaE: Double
    let avoidDeltaE: Double
    let bestMatch: Double
    let avoidMatch: Double?
    let contribution: Double
    let penalty: Double
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case color
        case hex
        case weight
        case bestDeltaE = "best_delta_e"
        case avoidDeltaE = "avoid_delta_e"
        case bestMatch = "best_match"
        case avoidMatch = "avoid_match"
        case contribution
        case penalty
    }
}

struct RecommendationFiltersDTO: Codable {
    let gender: String
    let bestColors: [String]
    let avoidColors: [String]
    
    enum CodingKeys: String, CodingKey {
        case gender
        case bestColors = "best_colors"
        case avoidColors = "avoid_colors"
    }
}
