//
//  ColorAnalysisResult.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct ColorAnalysisResult: Codable {
    let colorType: String
    let undertoneName: String
    let undertoneExplanation: String
    let skintoneName: String
    let skintoneExplanation: String
    let contrastName: String
    let contrastExplanation: String
    let bestColors: [AppColorRecommendation]
    let avoidColors: [AppColorRecommendation]
}

struct AppColorRecommendation: Codable, Identifiable {
    var id: String {
        hex
    }
    
    let name: String
    let hex: String
}
