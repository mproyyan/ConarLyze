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

// ColorAnalysisResult.swift

extension ColorAnalysisResult {
    
    func explanationInfo(for parameter: String) -> DetailInformation {
        switch parameter.lowercased() {
        case "undertone":
            return DetailInformation(
                title: "What is Undertone?",
                value: "Undertone is the natural color beneath your skin surface. Unlike skintone, it does not change even if your skin darkens from sun exposure or lightens from skincare.",
                questionResult: "How about your undertone?",
                answerResult: undertoneExplanation
            )
        case "skintone":
            return DetailInformation(
                title: "What is Skintone?",
                value: "Skintone refers to the visible depth or brightness of your skin color. Unlike undertone, skintone can change slightly because of tanning, sunlight, or skincare.",
                questionResult: "How about your skintone?",
                answerResult: skintoneExplanation
            )
        case "contrast":
            return DetailInformation(
                title: "What is Contrast?",
                value: "Contrast describes the visual difference between your facial features — especially between your skin, hair, eyes, and eyebrows.",
                questionResult: "How about your contrast?",
                answerResult: contrastExplanation
            )
        default:
            return DetailInformation(
                title: "What is \(parameter)?",
                value: "No description available.",
                questionResult: "Your result",
                answerResult: "No analysis data found."
            )
        }
    }
}
