//
//  OutfitCategoryChipView.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitCategoryChipView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(isSelected ? .white : .black)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected ? Color.black : Color.white)
            )
            .overlay(
                Capsule()
                    .stroke(
                        isSelected ? Color.clear : Color.black.opacity(0.06),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: Color.black.opacity(isSelected ? 0.08 : 0.06),
                radius: 10,
                x: 0,
                y: 4
            )
    }
}

#Preview {
    HStack(spacing: 10) {
        OutfitCategoryChipView(
            title: "All",
            isSelected: true
        )
        
        OutfitCategoryChipView(
            title: "Casual",
            isSelected: false
        )
        
        OutfitCategoryChipView(
            title: "Streetwear",
            isSelected: false
        )
    }
    .padding()
}
