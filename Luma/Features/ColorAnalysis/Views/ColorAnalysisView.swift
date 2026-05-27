//
//  ColorAnalysisView.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct ColorAnalysisView: View {
    @ObservedObject var viewModel: HomeViewModel
    let onRetakeCompleted: () -> Void
    
    @State private var showRetakeFlow = false
    
    init(
        viewModel: HomeViewModel,
        onRetakeCompleted: @escaping () -> Void = {}
    ) {
        self.viewModel = viewModel
        self.onRetakeCompleted = onRetakeCompleted
    }
    
    // MARK: - Dynamic Data
    
    private var analysis: ColorAnalysisModel {
        if let apiResult = viewModel.analysisResult {
            return ColorAnalysisModel.allSeasons.first {
                $0.seasonTitle.lowercased() == apiResult.colorType.lowercased()
            } ?? ColorAnalysisModel.dummy
        }
        
        return ColorAnalysisModel.dummy
    }
    
    private var dynamicInfos: [AnalysisInfoModel] {
        if let apiResult = viewModel.analysisResult {
            return [
                AnalysisInfoModel(title: "Undertone", value: apiResult.undertoneName),
                AnalysisInfoModel(title: "Skintone", value: apiResult.skintoneName),
                AnalysisInfoModel(title: "Contrast", value: apiResult.contrastName)
            ]
        }
        
        return analysis.infos
    }
    
    private var dynamicBestColors: [ColorSwatchModel] {
        if let apiResult = viewModel.analysisResult {
            return apiResult.bestColors.map {
                ColorSwatchModel(
                    title: $0.name,
                    hex: $0.hex,
                    color: Color(hex: $0.hex)
                )
            }
        }
        
        return analysis.bestColors
    }
    
    private var dynamicAvoidColors: [ColorSwatchModel] {
        if let apiResult = viewModel.analysisResult {
            return apiResult.avoidColors.map {
                ColorSwatchModel(
                    title: $0.name,
                    hex: $0.hex,
                    color: Color(hex: $0.hex)
                )
            }
        }
        
        return analysis.avoidColors
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Header
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Color Season")
                            .font(.title.bold())
                        
                        Text("Personal color analysis")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.trailing, 24)
                
                // MARK: - Season Wheel
                
                VStack(spacing: 8) {
                    SeasonWheelView(
                        imageName: "outfit-detail-image",
                        imageData: viewModel.userPhoto,
                        size: 260,
                        colors: dynamicBestColors.map { $0.color }
                    )
                    
                    Text(viewModel.analysisResult?.colorType.capitalized ?? analysis.seasonTitle.capitalized)
                        .font(.title3.weight(.semibold))
                    
                    Button {
                        showRetakeFlow = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "camera")
                            Text("Retake Analysis")
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.primaryColor)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.primaryColor.opacity(0.08))
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    
                    Text("AI-generated analysis. Results may vary depending on lighting and image quality.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: .infinity)
                .padding(.trailing, 24)
                
                // MARK: - Analysis Cards
                
                VStack(spacing: 12) {
                    ForEach(dynamicInfos) { item in
                        NavigationLink {
                            ColorParameterExplanation(
                                info: viewModel.analysisResult?.explanationInfo(for: item.title)
                                    ?? DetailInformation(
                                        title: "What is \(item.title)?",
                                        value: "No data available.",
                                        questionResult: "Your result",
                                        answerResult: "Analysis not yet loaded."
                                    )
                            )
                        } label: {
                            AnalysisInfoCard(
                                title: item.title,
                                value: item.value
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.trailing, 24)
              
              VStack(spacing: 24) {
                
                // MARK: - Best Colors
                
                ColorPaletteGrid(
                  title: "Your Best Colors",
                  colors: dynamicBestColors
                )
                
                // MARK: - Avoid Colors
                
                ColorPaletteGrid(
                  title: "Avoid These Color",
                  colors: dynamicAvoidColors
                )
              }
            }
            .padding(.leading, 24)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ColorAnalysisSwitchView(
                        userPhotoData: viewModel.userPhoto,
                        initialSelectedSeason: viewModel.analysisResult?.colorType
                            ?? analysis.seasonTitle
                    ) { selectedSeason in
                        await viewModel.updateColorSeason(to: selectedSeason)
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
        }
        .fullScreenCover(isPresented: $showRetakeFlow) {
            OnboardingFlowView(
                initialStep: .tutorial,
                dismissOnCompletion: true
            ) {
                await viewModel.refreshAfterRetakeAnalysis()
                onRetakeCompleted()
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ColorAnalysisView(viewModel: HomeViewModel())
}
