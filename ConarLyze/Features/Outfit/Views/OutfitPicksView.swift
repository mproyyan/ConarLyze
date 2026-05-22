//
//  OutfitPicksView.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitPicksView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCategory: String = "All"
    
    private let outfits: [OutfitItem] = OutfitItem.dummyList
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var filteredOutfits: [OutfitItem] {
        if selectedCategory == "All" {
            return outfits
        } else {
            return outfits.filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .shadow(
                                    color: Color.black.opacity(0.08),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                        )
                }
                
                Spacer()
                
                Text("Outfit Picks")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 10)
            
            // MARK: - Category Tab
            OutfitCategoryTabView(
                selectedCategory: $selectedCategory
            )
            .padding(.bottom, 16)
            
            // MARK: - Outfit Grid
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredOutfits) { outfit in
                        OutfitCardView(
                            imageName: outfit.imageName,
                            title: outfit.title,
                            colors: outfit.colors
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OutfitPicksView()
}
