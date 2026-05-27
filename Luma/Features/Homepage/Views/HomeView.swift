//
//  HomeView.swift
//  Luma
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct HomeView: View {
    private enum Route: Hashable {
        case colorAnalysis
    }
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: - Header
                    
                    HomeHeaderView(
                        userName: viewModel.userName
                    )
                    
                    // MARK: - Analysis Card
                    
                    NavigationLink(value: Route.colorAnalysis) {
                        AnalyzeCard(
                            cardType: cardTypeFromResult,
                            bestColors: viewModel.analysisResult?.bestColors.map {
                                Color(hex: $0.hex)
                            },
                            userPhotoData: viewModel.userPhoto
                        )
                    }
                    .buttonStyle(.plain)
                    .frame(height: 330)
                    
                    // MARK: - Fashion Ideas Section
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Text("CURATED FOR YOU")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.secondary)
                            }
                            
                            Text("Fashion Ideas")
                                .font(.title2.bold())
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(displayedOutfits, id: \.imageURL) { outfit in
                                NavigationLink {
                                    OutfitDetailView(outfit: outfit)
                                } label: {
                                    FashionIdeaCard(outfit: outfit)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    // MARK: - Browse More
                    
                    if let totalLooks = browseTotalLooks {
                        NavigationLink {
                            OutfitPicksView(
                                bestColors: viewModel.analysisResult?.bestColors ?? [],
                                avoidColors: viewModel.analysisResult?.avoidColors ?? [],
                                gender: viewModel.userGender
                            )
                        } label: {
                            BrowseMoreButton(
                                totalLooks: totalLooks
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .background(
                Color(.systemGroupedBackground)
            )
            .task {
                viewModel.loadLocalData()
                await viewModel.loadOutfitRecommendationsIfNeeded()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .colorAnalysis:
                    ColorAnalysisView(viewModel: viewModel) {
                        navigationPath = NavigationPath()
                    }
                }
            }
        }
    }
    
    // MARK: - Displayed Outfits
    
    private var displayedOutfits: [RecommendedOutfit] {
        if viewModel.recommendedOutfits.isEmpty && isRunningPreview {
            return Self.previewOutfits
        }
        
        return Array(viewModel.recommendedOutfits.prefix(3))
    }
    
    // MARK: - Browse Count
    
    private var browseTotalLooks: Int? {
        if let totalLooks = viewModel.totalLooks {
            return totalLooks
        }
        
        if isRunningPreview {
            return 112
        }
        
        return nil
    }
    
    private var isRunningPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // MARK: - Analysis Mapping
    
    private var cardTypeFromResult: AnalyzeCard.CardType {
        guard let result = viewModel.analysisResult else {
            return .softSummer
        }
        
        return AnalyzeCard.CardType.from(
            colorType: result.colorType
        )
    }
    
    // MARK: - Preview Data
    
    private static let previewOutfits: [RecommendedOutfit] = [
        RecommendedOutfit(
            id: "preview-1",
            name: "Olive Night Motion",
            imageURL: "https://images.unsplash.com/photo-1516257984-b1b4d707412e?q=80&w=800",
            gender: "male",
            styleTag: "streetwear",
            harmonyTag: "earth tone",
            undertone: "warm",
            contrastLevel: "medium",
            environments: ["casual"],
            weatherSupport: ["sunny"],
            items: [
                RecommendedOutfitItem(
                    key: "outer",
                    name: "Olive Jacket",
                    color: "Olive",
                    hex: "#556B2F"
                ),
                RecommendedOutfitItem(
                    key: "top",
                    name: "Cream Shirt",
                    color: "Cream",
                    hex: "#F3EAD7"
                ),
                RecommendedOutfitItem(
                    key: "bottom",
                    name: "Brown Pants",
                    color: "Brown",
                    hex: "#6B4A2B"
                ),
                RecommendedOutfitItem(
                    key: "shoes",
                    name: "Black Shoes",
                    color: "Black",
                    hex: "#111111"
                )
            ],
            score: 0.95,
            reasons: [],
            rank: 1
        ),
        RecommendedOutfit(
            id: "preview-2",
            name: "Golden Night Tailoring",
            imageURL: "https://images.unsplash.com/photo-1516826957135-700dedea698c?q=80&w=800",
            gender: "male",
            styleTag: "formal",
            harmonyTag: "warm neutral",
            undertone: "warm",
            contrastLevel: "medium",
            environments: ["formal"],
            weatherSupport: ["cool"],
            items: [
                RecommendedOutfitItem(
                    key: "outer",
                    name: "Camel Coat",
                    color: "Camel",
                    hex: "#C19A5B"
                ),
                RecommendedOutfitItem(
                    key: "top",
                    name: "Cream Turtleneck",
                    color: "Cream",
                    hex: "#F3EAD7"
                ),
                RecommendedOutfitItem(
                    key: "bottom",
                    name: "Dark Brown Trousers",
                    color: "Dark Brown",
                    hex: "#4A3323"
                ),
                RecommendedOutfitItem(
                    key: "shoes",
                    name: "Brown Loafers",
                    color: "Brown",
                    hex: "#A65A2E"
                )
            ],
            score: 0.92,
            reasons: [],
            rank: 2
        ),
        RecommendedOutfit(
            id: "preview-3",
            name: "Mustard Street Motion",
            imageURL: "https://images.unsplash.com/photo-1516257984-b1b4d707412e?q=80&w=800",
            gender: "male",
            styleTag: "streetwear",
            harmonyTag: "warm casual",
            undertone: "warm",
            contrastLevel: "medium",
            environments: ["casual"],
            weatherSupport: ["sunny"],
            items: [
                RecommendedOutfitItem(
                    key: "top",
                    name: "Mustard Hoodie",
                    color: "Mustard",
                    hex: "#C9A227"
                ),
                RecommendedOutfitItem(
                    key: "bottom",
                    name: "Olive Cargo Pants",
                    color: "Olive",
                    hex: "#6B705C"
                ),
                RecommendedOutfitItem(
                    key: "shoes",
                    name: "Taupe Sneakers",
                    color: "Taupe",
                    hex: "#B7A57A"
                ),
                RecommendedOutfitItem(
                    key: "accessory",
                    name: "Cream Cap",
                    color: "Cream",
                    hex: "#F3EAD7"
                )
            ],
            score: 0.89,
            reasons: [],
            rank: 3
        )
    ]
}

#Preview {
    HomeView()
}
