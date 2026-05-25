//
//  OutfitItem.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let category: String
    let colors: [Color]
}

extension OutfitItem {
    static let softNeutralColors: [Color] = [
        Color(red: 0.32, green: 0.20, blue: 0.13),
        Color(red: 0.60, green: 0.36, blue: 0.18),
        Color(red: 0.88, green: 0.76, blue: 0.62),
        Color(red: 0.55, green: 0.58, blue: 0.48),
        Color(red: 0.86, green: 0.88, blue: 0.86)
    ]
    
    static let dummyList: [OutfitItem] = [
        // MARK: - Casual 6 Data
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Soft Neutrals",
            category: "Casual",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Earth Casual",
            category: "Casual",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Warm Layers",
            category: "Casual",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Daily Brown",
            category: "Casual",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Relaxed Fit",
            category: "Casual",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Simple Casual",
            category: "Casual",
            colors: softNeutralColors
        ),
        
        // MARK: - Formal 6 Data
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Soft Formal",
            category: "Formal",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Office Brown",
            category: "Formal",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Clean Formal",
            category: "Formal",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Warm Office",
            category: "Formal",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Neutral Suit",
            category: "Formal",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Smart Brown",
            category: "Formal",
            colors: softNeutralColors
        ),
        
        // MARK: - Streetwear 6 Data
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Soft Street",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Urban Brown",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Layered Street",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Street Neutral",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Warm Street",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Casual Street",
            category: "Streetwear",
            colors: softNeutralColors
        ),
        
        // MARK: - Minimalist 6 Data
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Soft Minimal",
            category: "Minimalist",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Clean Neutral",
            category: "Minimalist",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Minimal Brown",
            category: "Minimalist",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Simple Earth",
            category: "Minimalist",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Muted Minimal",
            category: "Minimalist",
            colors: softNeutralColors
        ),
        OutfitItem(
            imageName: "outfit-detail-image",
            title: "Daily Minimal",
            category: "Minimalist",
            colors: softNeutralColors
        )
    ]
}
