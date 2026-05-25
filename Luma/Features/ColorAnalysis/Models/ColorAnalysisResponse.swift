//
//  ColorAnalysisResponse.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct ColorAnalysisResponse: Codable {
    let colorType: String
    let undertone: AnalysisCategory
    let skintone: AnalysisCategory
    let contrast: AnalysisCategory
    let bestColors: [ColorRecommendation]
    let avoidColor: [ColorRecommendation]
    
    enum CodingKeys: String, CodingKey {
        case colorType = "color_type"
        case undertone
        case skintone
        case contrast
        case bestColors = "best_colors"
        case avoidColor = "avoid_color"
    }
}

struct AnalysisCategory: Codable {
    let explanation: String
    let value: AnalysisValue
}

struct AnalysisValue: Codable {
    let name: String
    let explanation: String
}

struct ColorRecommendation: Codable, Identifiable {
    var id: String { hex }
    
    let name: String
    let hex: String
}
