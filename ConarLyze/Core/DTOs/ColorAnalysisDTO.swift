//
//  ColorAnalysisDTO.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct ColorAnalysisResponseDTO: Codable {
    let colorType: String
    let undertone: AnalysisCategoryDTO
    let skintone: AnalysisCategoryDTO
    let contrast: AnalysisCategoryDTO
    let bestColors: [ColorRecommendationDTO]
    let avoidColor: [ColorRecommendationDTO]
    
    enum CodingKeys: String, CodingKey {
        case colorType = "color_type"
        case undertone
        case skintone
        case contrast
        case bestColors = "best_colors"
        case avoidColor = "avoid_color"
    }
}

struct AnalysisCategoryDTO: Codable {
    let explanation: String
    let value: AnalysisValueDTO
}

struct AnalysisValueDTO: Codable {
    let name: String
    let explanation: String
}

struct ColorRecommendationDTO: Codable {
    let name: String
    let hex: String
}
