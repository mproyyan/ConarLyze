//
//  ColorAnalysisSwitchView.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 24/05/26.
//

import SwiftUI

struct ColorAnalysisSwitchView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let analysis = ColorAnalysisModel.allSeasons
    let userPhotoData: Data?
    let initialSelectedSeason: String
    let onSeasonSelected: (String) async -> Void
    
    @State private var selectedSeason: String?
    @State private var isUpdating = false
    
    init(
        userPhotoData: Data?,
        initialSelectedSeason: String,
        onSeasonSelected: @escaping (String) async -> Void = { _ in }
    ) {
        self.userPhotoData = userPhotoData
        self.initialSelectedSeason = initialSelectedSeason
        self.onSeasonSelected = onSeasonSelected
        _selectedSeason = State(initialValue: initialSelectedSeason)
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(analysis, id: \.seasonTitle) { item in
                        Button {
                            handleSeasonSelection(item.seasonTitle)
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                ColorWheelCard(
                                    analysis: item,
                                    userPhotoData: userPhotoData
                                )
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .background(
                                    isSelected(item.seasonTitle)
                                    ? Color.primary.opacity(0.08)
                                    : Color(.systemGray6)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 32)
                                        .stroke(
                                            isSelected(item.seasonTitle)
                                            ? Color.primary.opacity(0.8)
                                            : Color.clear,
                                            lineWidth: 2
                                        )
                                }
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 32)
                                )
                                
                                if isSelected(item.seasonTitle) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.primaryColor)
                                            .frame(width: 36, height: 36)
                                        
                                        if isUpdating {
                                            ProgressView()
                                                .tint(.white)
                                        } else {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    .padding(20)
                                    .transition(.scale.combined(with: .opacity))
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .disabled(isUpdating)
                    }
                }
                .padding()
            }
            
            if isUpdating {
                Color.black.opacity(0.05)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Choose Your Color Type")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
    
    private func handleSeasonSelection(_ seasonTitle: String) {
        withAnimation(.spring(duration: 0.35)) {
            selectedSeason = seasonTitle
            isUpdating = true
        }
        
        Task {
            await onSeasonSelected(seasonTitle)
            
            await MainActor.run {
                isUpdating = false
                dismiss()
            }
        }
    }
    
    private func isSelected(_ seasonTitle: String) -> Bool {
        normalizedSeason(selectedSeason ?? "") == normalizedSeason(seasonTitle)
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
