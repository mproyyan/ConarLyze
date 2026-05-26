//
//  ColorAnalysisSwitchView.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 24/05/26.
//

import SwiftUI

struct ColorAnalysisSwitchView: View {
    
    let analysis = ColorAnalysisModel.allSeasons
    let userPhotoData: Data?
    let initialSelectedSeason: String
    
    @State private var selectedSeason: String?
    
    init(
        userPhotoData: Data?,
        initialSelectedSeason: String
    ) {
        self.userPhotoData = userPhotoData
        self.initialSelectedSeason = initialSelectedSeason
        _selectedSeason = State(initialValue: initialSelectedSeason)
    }
    
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
                                analysis: item,
                                userPhotoData: userPhotoData
                            )
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            
                            // MARK: - Background
                            
                            .background(
                                normalizedSeason(selectedSeason ?? "")
                                ==
                                normalizedSeason(item.seasonTitle)                                ? Color.primary.opacity(0.08)
                                : Color(.systemGray6)
                            )
                            
                            // MARK: - Border
                            
                            .overlay {
                                
                                RoundedRectangle(cornerRadius: 32)
                                    .stroke(
                                        normalizedSeason(selectedSeason ?? "")
                                        ==
                                        normalizedSeason(item.seasonTitle)                                        ? Color.primary.opacity(0.8)
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
                            
                            if normalizedSeason(selectedSeason ?? "")
                                ==
                                normalizedSeason(item.seasonTitle) {
                                
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

private func normalizedSeason(_ value: String) -> String {
    value
        .lowercased()
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .replacingOccurrences(of: "_", with: " ")
        .replacingOccurrences(of: "-", with: " ")
}

#Preview {
    NavigationStack {
        ColorAnalysisSwitchView(
            userPhotoData: nil,
            initialSelectedSeason: "Warm Spring"
        )
    }
}
