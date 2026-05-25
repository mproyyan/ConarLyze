//
//  OutfitPicksView.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitPicksView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = OutfitViewModel()
    @State private var selectedCategory: String = "All"
    
    let bestColors: [AppColorRecommendation]
    let avoidColors: [AppColorRecommendation]
    let gender: String
    
    init(
        bestColors: [AppColorRecommendation] = [],
        avoidColors: [AppColorRecommendation] = [],
        gender: String = "male"
    ) {
        self.bestColors = bestColors
        self.avoidColors = avoidColors
        self.gender = gender
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var filteredOutfits: [RecommendedOutfit] {
        if selectedCategory == "All" {
            return viewModel.recommendedOutfits
        } else {
            let categoryForBackend = selectedCategory == "Smart Casual" ? "smart_casual" : selectedCategory.lowercased()
            return viewModel.recommendedOutfits.filter {
                $0.styleTag.lowercased() == categoryForBackend
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            OutfitCategoryTabView(
                selectedCategory: $selectedCategory
            )
            .padding(.bottom, 16)
            
            contentView
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadRecommendations(
                bestColors: bestColors,
                avoidColors: avoidColors,
                gender: gender
            )
        }
    }
    
    // MARK: - Header
    
    private var headerView: some View {
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
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            Spacer()
            
            ProgressView("Loading outfits...")
                .font(.system(size: 14, weight: .medium))
            
            Spacer()
        } else if let errorMessage = viewModel.errorMessage {
            Spacer()
            
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(.orange)
                
                Text("Failed to load outfits")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                Button {
                    Task {
                        await viewModel.loadRecommendations(
                            bestColors: bestColors,
                            avoidColors: avoidColors,
                            gender: gender
                        )
                    }
                } label: {
                    Text("Try Again")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(Color.black)
                        )
                }
            }
            
            Spacer()
        } else if filteredOutfits.isEmpty {
            Spacer()
            
            VStack(spacing: 12) {
                Image(systemName: "tshirt")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(.secondary)
                
                Text("No outfits found")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text("Try another category or refresh your recommendation.")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
            
            Spacer()
        } else {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredOutfits) { outfit in
                        NavigationLink {
                            OutfitDetailView(outfit: outfit)
                        } label: {
                            RecommendedOutfitCardView(outfit: outfit)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
    }
}

// MARK: - Recommended Outfit Card

private struct RecommendedOutfitCardView: View {
    let outfit: RecommendedOutfit
    
    private var colors: [Color] {
        outfit.items.compactMap {
            Color(hexString: $0.hex)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: outfit.imageURL)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .overlay {
                            ProgressView()
                        }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure:
                    Image("outfit-detail-image")
                        .resizable()
                        .scaledToFill()
                    
                @unknown default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .clipped()
            
            LinearGradient(
                colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.75)
                ],
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(outfit.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                HStack(spacing: 6) {
                    ForEach(Array(colors.prefix(5).enumerated()), id: \.offset) { _, color in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(color)
                            .frame(width: 18, height: 18)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 14)
        }
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(
            color: Color.black.opacity(0.08),
            radius: 8,
            x: 0,
            y: 4
        )
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
        
        self = Color(
            red: red,
            green: green,
            blue: blue
        )
    }
}

#Preview {
    NavigationStack {
        OutfitPicksView()
    }
}
