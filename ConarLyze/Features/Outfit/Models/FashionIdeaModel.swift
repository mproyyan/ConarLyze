//
//  FashionIdeaModel.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct FashionIdeaModel: Identifiable {
    let id = UUID()
    let title: String
    let style: String
    let imageName: String
    let colors: [Color]
}

// MARK: - Dummy Data
extension FashionIdeaModel {
    static let dummy: [FashionIdeaModel] = [
        
        FashionIdeaModel(
            title: "Earthy Essentials",
            style: "Casual",
            imageName: "fashion-idea-image",
            colors: [
                Color(hex: 0x433024),
                Color(hex: 0x985E32),
                Color(hex: 0xE5CBAF),
                Color(hex: 0x969683),
                Color(hex: 0xD3D4D3)
            ]
        ),
        
        FashionIdeaModel(
            title: "Earthy Essentials",
            style: "Casual",
            imageName: "fashion-idea-image",
            colors: [
                Color(hex: 0x433024),
                Color(hex: 0x985E32),
                Color(hex: 0xE5CBAF),
                Color(hex: 0x969683),
                Color(hex: 0xD3D4D3)
            ]
        )
    ]
}
