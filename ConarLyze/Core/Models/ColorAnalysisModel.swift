//
//  ColorAnalysisModel.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct AnalysisInfoModel: Identifiable {
    
    let id = UUID()
    let title: String
    let value: String
}

struct ColorSwatchModel: Identifiable {
    
    let id = UUID()
    let title: String
    let hex: String
    let color: Color
}

struct ColorAnalysisModel {
    let seasonTitle: String
    let infos: [AnalysisInfoModel]
    let bestColors: [ColorSwatchModel]
    let avoidColors: [ColorSwatchModel]
}

// MARK: - Dummy Data

extension ColorAnalysisModel {
    static let dummy = ColorAnalysisModel(
        
        seasonTitle: "Soft Summer",
        infos: [
            AnalysisInfoModel(
                title: "Undertone",
                value: "Cool to Neutral Cool",
            ),
            AnalysisInfoModel(
                title: "Skintone",
                value: "Soft & Muted",
            ),
            AnalysisInfoModel(
                title: "Contrast",
                value: "Low Contrast",
            )
        ],
        bestColors: [
            ColorSwatchModel(
                title: "Dark Blue",
                hex: "#111827",
                color: Color(hex: 0x111827)
            ),
            ColorSwatchModel(
                title: "Navy",
                hex: "#1F3B73",
                color: Color(hex: 0x1F3B73)
            ),
            ColorSwatchModel(
                title: "Blue",
                hex: "#4A90FF",
                color: Color(hex: 0x4A90FF)
            ),
            ColorSwatchModel(
                title: "Sky Blue",
                hex: "#DCEBFF",
                color: Color(hex: 0xDCEBFF)
            ),
            ColorSwatchModel(
                title: "Dark Blue",
                hex: "#111827",
                color: Color(hex: 0x111827)
            ),
            ColorSwatchModel(
                title: "Navy",
                hex: "#1F3B73",
                color: Color(hex: 0x1F3B73)
            ),
            ColorSwatchModel(
                title: "Blue",
                hex: "#4A90FF",
                color: Color(hex: 0x4A90FF)
            ),
            ColorSwatchModel(
                title: "Sky Blue",
                hex: "#DCEBFF",
                color: Color(hex: 0xDCEBFF)
            )
        ],
        
        avoidColors: [
            ColorSwatchModel(
                title: "Bright Orange",
                hex: "#FF8800",
                color: Color(hex: 0xFF8800)
            ),
            ColorSwatchModel(
                title: "Neon Yellow",
                hex: "#FFF200",
                color: Color(hex: 0xFFF200)
            ),
            ColorSwatchModel(
                title: "Bright Red",
                hex: "#FF1E1E",
                color: Color(hex: 0xFF1E1E)
            ),
            ColorSwatchModel(
                title: "Sky Green",
                hex: "#A4FF00",
                color: Color(hex: 0xA4FF00)
            ),
            ColorSwatchModel(
                title: "Bright Orange",
                hex: "#FF8800",
                color: Color(hex: 0xFF8800)
            ),
            ColorSwatchModel(
                title: "Neon Yellow",
                hex: "#FFF200",
                color: Color(hex: 0xFFF200)
            ),
            ColorSwatchModel(
                title: "Bright Red",
                hex: "#FF1E1E",
                color: Color(hex: 0xFF1E1E)
            ),
            ColorSwatchModel(
                title: "Sky Green",
                hex: "#A4FF00",
                color: Color(hex: 0xA4FF00)
            )
        ]
    )
}
