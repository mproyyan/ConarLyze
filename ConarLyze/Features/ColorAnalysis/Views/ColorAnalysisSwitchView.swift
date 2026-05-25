//
//  ColorAnalysisSwitchView.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 24/05/26.
//

import SwiftUI

struct ColorAnalysisSwitchView: View {
    
    let analysis = ColorAnalysisModel.allSeasons
    
    @State private var selectedSeason: String? = "Soft Summer"
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 24) {
                
                ForEach(analysis, id: \.seasonTitle) { item in
                    
                    Button {
                        
                        withAnimation(.spring(duration: 0.35)) {
                            selectedSeason = item.seasonTitle
                        }
                        
                    } label: {
                        
                        ZStack(alignment: .topTrailing) {
                            
                            ColorWheelCard(
                                analysis: item
                            )
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            
                            // MARK: - Background
                            
                            .background(
                                selectedSeason == item.seasonTitle
                                ? Color.primary.opacity(0.08)
                                : Color(.systemGray6)
                            )
                            
                            // MARK: - Border
                            
                            .overlay {
                                
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(
                                        selectedSeason == item.seasonTitle
                                        ? Color.primary.opacity(0.8)
                                        : Color.clear,
                                        lineWidth: 2
                                    )
                            }
                            
                            .clipShape(
                                RoundedRectangle(cornerRadius: 32)
                            )
                            
//                            // MARK: - Unselected Effect
//                            
//                            .opacity(
//                                selectedSeason == item.seasonTitle
//                                ? 1
//                                : 0.55
//                            )
//                            
//                            .blur(
//                                radius: selectedSeason == item.seasonTitle
//                                ? 0
//                                : 1.2
//                            )
//                            
//                            .scaleEffect(
//                                selectedSeason == item.seasonTitle
//                                ? 1
//                                : 0.96
//                            )
//                            
//                            .shadow(
//                                color: selectedSeason == item.seasonTitle
//                                ? .black.opacity(0.12)
//                                : .clear,
//                                radius: 14,
//                                y: 8
//                            )
                            
                            
                            // MARK: - Checkmark
                            
                            if selectedSeason == item.seasonTitle {
                                
                                ZStack {
                                    
                                    Circle()
                                        .fill(Color.primaryColor)
                                        .frame(width: 36, height: 36)
                                    
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                                .padding(20)
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle("Choose Your Color Type")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        ColorAnalysisSwitchView()
    }
}
