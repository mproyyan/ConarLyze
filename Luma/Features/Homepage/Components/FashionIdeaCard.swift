//
//  FashionIdeaCard.swift
//  Luma
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct FashionIdeaCard: View {
    //    let item: FashionIdeaModel
    let outfit: RecommendedOutfit
    
    private var colors: [Color] {
        outfit.items.map {
            Color(hex: $0.hex)
        }
    }
    
    //    var body: some View {
    //
    //        HStack(spacing: 16) {
    //            Image("outfit")
    //                .resizable()
    //                .scaledToFill()
    //                .frame(width: 112, height: 168)
    //                .clipShape(
    //                    RoundedRectangle(cornerRadius: 20)
    //                )
    //            VStack(alignment: .leading, spacing: 16) {
    //                Spacer()
    //                Text(item.title)
    //                    .font(.title3.weight(.semibold))
    //                ColorPaletteView(
    //                    colors: item.colors
    //                )
    //                Text(item.style)
    //                    .font(.headline)
    //                    .foregroundStyle(.secondary)
    //
    //                Spacer()
    //            }
    //            Spacer()
    //        }
    //        .padding(16)
    //        .background(Color.white)
    //        .clipShape(
    //            RoundedRectangle(cornerRadius: 28)
    //        )
    //    }
    //}
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            // MARK: - Outfit Image
            
            AsyncImage(url: URL(string: outfit.imageURL)) { phase in
                
                switch phase {
                    
                case .empty:
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.08))
                        .overlay {
                            ProgressView()
                        }
                
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                
                case .failure:
                    Image("outfit")
                        .resizable()
                        .scaledToFill()
                
                @unknown default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.08))
                }
            }
            .id(outfit.imageURL)
            .frame(width: 112, height: 168)
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            
            // MARK: - Content
            
            VStack(alignment: .leading, spacing: 16) {
                
                Spacer()
                
                // MARK: - Title
                Text(
                    outfit.name
                        .replacingOccurrences(of: "_", with: " ")
                        .replacingOccurrences(of: "-", with: " ")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .capitalized
                )
                .font(.title3.weight(.semibold))
                .foregroundStyle(.black)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(height: 68, alignment: .topLeading)
                
                // MARK: - Existing Palette Component
                ColorPaletteView(
                    colors: Array(colors.prefix(5))
                )
                
                // MARK: - Style
                Text(
                    outfit.styleTag
                        .replacingOccurrences(of: "_", with: " ")
                        .capitalized
                )
                .font(.headline)
                .foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 28)
        )
    }
}

#Preview {
    HomeView()
}
