//
//  OutfitCategoryTabView.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitCategoryTabView: View {
    @Binding var selectedCategory: String
    
    let categories: [String] = [
        "All",
        "Casual",
        "Formal",
        "Streetwear",
        "Minimalist"
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    OutfitCategoryChipView(
                        title: category,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    @Previewable @State var selectedCategory = "Formal"
    
    OutfitCategoryTabView(
        selectedCategory: $selectedCategory
    )
}
