//
//  HomeView.swift
//  Luma
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: - Header
                    
                    HomeHeaderView(
                        userName: viewModel.userName
                    )
                    
                    // MARK: - Analysis Card
                    
                    NavigationLink {
                        ColorAnalysisView()
                    } label: {
                        AnalyzeCard(
                            cardType: cardTypeFromResult,
                            bestColors: viewModel.analysisResult?.bestColors.map { Color(hex: $0.hex) },
                            userPhotoData: viewModel.userPhoto
                        )
                    }
                    .buttonStyle(.plain)
                    .frame(height: 330)
                    
                    // MARK: - Fashion Ideas Section
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Image(systemName: "tshirt")
                                    .foregroundStyle(.secondary)
                                
                                Text("CURATED FOR YOU")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text("Fashion Ideas")
                                .font(.largeTitle.bold())
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(viewModel.ideas) { item in
                                NavigationLink {
                                    OutfitDetailView()
                                } label: {
                                    FashionIdeaCard(item: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    // MARK: - Browse More

                    // MARK: - Browse More

                    if let totalLooks = viewModel.totalLooks {
                        NavigationLink {
                            OutfitPicksView(
                                bestColors: viewModel.analysisResult?.bestColors ?? [],
                                avoidColors: viewModel.analysisResult?.avoidColors ?? [],
                                gender: viewModel.userGender
                            )
                        } label: {
                            BrowseMoreButton(totalLooks: totalLooks)
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
        }
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
}

#Preview {
    HomeView()
}
