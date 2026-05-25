//
//  DTOMapper.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

extension ColorAnalysisResponseDTO {
    func toDomain() -> ColorAnalysisResult {
        ColorAnalysisResult(
            colorType: colorType,
            undertoneName: undertone.value.name,
            undertoneExplanation: undertone.value.explanation,
            skintoneName: skintone.value.name,
            skintoneExplanation: skintone.value.explanation,
            contrastName: contrast.value.name,
            contrastExplanation: contrast.value.explanation,
            bestColors: bestColors.map {
                AppColorRecommendation(
                    name: $0.name,
                    hex: $0.hex
                )
            },
            avoidColors: avoidColor.map {
                AppColorRecommendation(
                    name: $0.name,
                    hex: $0.hex
                )
            }
        )
    }
}

extension OutfitDTO {
    func toDomain(
        score: Double? = nil,
        reasons: [String] = [],
        rank: Int? = nil
    ) -> RecommendedOutfit {
        var mappedItems: [RecommendedOutfitItem] = []
        
        if let outer = items.outer {
            mappedItems.append(
                RecommendedOutfitItem(
                    key: "outer",
                    name: outer.name,
                    color: outer.color,
                    hex: outer.hex
                )
            )
        }
        
        if let top = items.top {
            mappedItems.append(
                RecommendedOutfitItem(
                    key: "top",
                    name: top.name,
                    color: top.color,
                    hex: top.hex
                )
            )
        }
        
        if let bottom = items.bottom {
            mappedItems.append(
                RecommendedOutfitItem(
                    key: "bottom",
                    name: bottom.name,
                    color: bottom.color,
                    hex: bottom.hex
                )
            )
        }
        
        if let shoes = items.shoes {
            mappedItems.append(
                RecommendedOutfitItem(
                    key: "shoes",
                    name: shoes.name,
                    color: shoes.color,
                    hex: shoes.hex
                )
            )
        }
        
        return RecommendedOutfit(
            id: id,
            name: name,
            imageURL: imageURL,
            gender: gender,
            styleTag: styleTag,
            harmonyTag: harmonyTag,
            undertone: undertone,
            contrastLevel: contrastLevel,
            environments: environments,
            weatherSupport: weatherSupport,
            items: mappedItems,
            score: score,
            reasons: reasons,
            rank: rank
        )
    }
}

extension RecommendationResultDTO {
    func toDomain() -> RecommendedOutfit {
        outfit.toDomain(
            score: score,
            reasons: reasons,
            rank: rank
        )
    }
}
