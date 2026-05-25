//
//  OutfitDetailView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct OutfitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Data
    
    private let recommendedOutfit: RecommendedOutfit?
    private let dummyOutfit = OutfitDetailModel.dummy
    
    // MARK: - Init
    
    init(outfit: RecommendedOutfit? = nil) {
        self.recommendedOutfit = outfit
    }
    
    // MARK: - Layout
    
    private let imageHeight: CGFloat = 560
    
    // MARK: - Computed Data
    
    private var outfitTitle: String {
        recommendedOutfit?.name ?? dummyOutfit.title
    }
    
    private var outfitColors: [Color] {
        if let recommendedOutfit {
            let colors = recommendedOutfit.items.compactMap {
                Color(hexString: $0.hex)
            }
            return colors.isEmpty ? dummyOutfit.colors : colors
        } else {
            return dummyOutfit.colors
        }
    }
    
    private var outfitKeywords: [OutfitKeywordModel] {
        if let recommendedOutfit {
            return recommendedOutfit.items.map { item in
                OutfitKeywordModel(
                    icon: iconName(for: item.key),
                    title: titleName(for: item.key),
                    description: "\(item.name), \(item.color)"
                )
            }
        } else {
            return dummyOutfit.keywords
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        // MARK: - Outfit Image
                        
                        outfitImageView
                            .frame(
                                width: proxy.size.width,
                                // Tambah extra height agar gambar lebih tinggi
                                // sehingga kepala tidak terpotong Dynamic Island
                                height: imageHeight + proxy.safeAreaInsets.top 
                            )
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                        
                        // MARK: - Bottom Content
                        
                        VStack(alignment: .leading, spacing: 32) {
                            
                            // MARK: - Outfit Header
                            
                            OutfitHeaderView(
                                title: outfitTitle,
                                colors: outfitColors
                            )
                            
                            // MARK: - Style Keywords Section
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Style Keywords")
                                    .font(.title3.weight(.medium))
                                
                                ForEach(outfitKeywords) { item in
                                    OutfitKeywordRow(
                                        icon: item.icon,
                                        title: item.title,
                                        description: item.description
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 36)
                        .padding(.bottom, 48)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 40)
                        )
                        .offset(y: -32)
                        .padding(.bottom, -32)
                    }
                }
                .ignoresSafeArea(edges: .top)
                
                // MARK: - Top Navigation
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.black)
                                .frame(width: 44, height: 44)
                                .glassEffect()
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
                .safeAreaPadding(.top, 8)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Image View
    
    @ViewBuilder
    private var outfitImageView: some View {
        if let recommendedOutfit,
           let url = URL(string: recommendedOutfit.imageURL) {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.12))
                        .overlay { ProgressView() }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                case .failure:
                    Image(dummyOutfit.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                @unknown default:
                    Image(dummyOutfit.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
            
        } else {
            Image(dummyOutfit.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    // MARK: - Helpers
    
    private func iconName(for key: String) -> String {
        let normalizedKey = key.lowercased()
        
        if normalizedKey.contains("top") ||
            normalizedKey.contains("shirt") ||
            normalizedKey.contains("tshirt") {
            return "tshirt"
        }
        
        if normalizedKey.contains("bottom") ||
            normalizedKey.contains("pants") ||
            normalizedKey.contains("trouser") {
            return "figure.walk"
        }
        
        if normalizedKey.contains("outer") ||
            normalizedKey.contains("jacket") ||
            normalizedKey.contains("coat") {
            return "tshirt"
        }
        
        if normalizedKey.contains("shoe") ||
            normalizedKey.contains("sneaker") ||
            normalizedKey.contains("loafer") {
            return "shoeprints.fill"
        }
        
        return "tag"
    }
    
    private func titleName(for key: String) -> String {
        let normalizedKey = key.lowercased()
        
        if normalizedKey.contains("top") ||
            normalizedKey.contains("shirt") ||
            normalizedKey.contains("tshirt") {
            return "Tops"
        }
        
        if normalizedKey.contains("bottom") ||
            normalizedKey.contains("pants") ||
            normalizedKey.contains("trouser") {
            return "Bottoms"
        }
        
        if normalizedKey.contains("outer") ||
            normalizedKey.contains("jacket") ||
            normalizedKey.contains("coat") {
            return "Outer"
        }
        
        if normalizedKey.contains("shoe") ||
            normalizedKey.contains("sneaker") ||
            normalizedKey.contains("loafer") {
            return "Shoes"
        }
        
        return key
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
    }
}

// MARK: - Hex Color Helper

private extension Color {
    init?(hexString: String) {
        var cleanedHex = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }
        
        guard cleanedHex.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self = Color(red: red, green: green, blue: blue)
    }
}

#Preview {
    OutfitDetailView()
}
