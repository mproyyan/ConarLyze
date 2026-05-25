//
//  OutfitDetailModel.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct OutfitKeywordModel: Identifiable {
    
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}

struct OutfitDetailModel {
    
    let title: String
    let imageName: String
    let colors: [Color]
    let keywords: [OutfitKeywordModel]
}

// MARK: - Dummy Data
extension OutfitDetailModel {
    
    static let dummy = OutfitDetailModel(
        title: "Soft Neutrals",
        imageName: "outfit-detail-image",
        colors: [
            Color(hex: 0x433024),
            Color(hex: 0x969683),
            Color(hex: 0x985E32),
            Color(hex: 0xD3D4D3),
            Color(hex: 0xE5CBAF)
        ],
        keywords: [
            // MARK: - Tops
            OutfitKeywordModel(
                icon: "tshirt",
                title: "Tops",
                description: "White Polo, Beige Knit, Navy Tee"
            ),
            
            // MARK: - Bottoms
            OutfitKeywordModel(
                icon: "figure.walk",
                title: "Bottoms",
                description: "Beige Chino, Light Gray Trousers, Navy Pants"
            ),
            
            // MARK: - Outer
            
            OutfitKeywordModel(
                icon: "jacket",
                title: "Outer",
                description: "Brown Bomber, Beige Blazer, Light Trench Coat"
            ),
            
            // MARK: - Shoes
            OutfitKeywordModel(
                icon: "shoeprints.fill",
                title: "Shoes",
                description: "White Sneakers, Brown Loafers, Suede Derbies"
            )
        ]
    )
}
