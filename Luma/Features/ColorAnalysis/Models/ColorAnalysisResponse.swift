//
//  ColorAnalysisResponse.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

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
    
    // FUNGSI MAPPER: Mengubah format bersarang (Response) menjadi format datar (Result)
    func toDomain() -> ColorAnalysisResult {
        let mappedBestColors = self.bestColors.map {
            AppColorRecommendation(name: $0.name, hex: $0.hex)
        }
        
        let mappedAvoidColors = self.avoidColor.map {
            AppColorRecommendation(name: $0.name, hex: $0.hex)
        }
        
        return ColorAnalysisResult(
            colorType: self.colorType,
            undertoneName: self.undertone.value.name,
            undertoneExplanation: self.undertone.value.explanation,
            skintoneName: self.skintone.value.name,
            skintoneExplanation: self.skintone.value.explanation,
            contrastName: self.contrast.value.name,
            contrastExplanation: self.contrast.value.explanation,
            bestColors: mappedBestColors,
            avoidColors: mappedAvoidColors
        )
    }
}

// Sudah diperbaiki typo namanya dari AnalyasisCategory menjadi AnalysisCategory
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
