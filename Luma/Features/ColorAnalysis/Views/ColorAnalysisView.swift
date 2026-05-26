//
//  ColorAnalysisView.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

//
//  ColorAnalysisView.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct ColorAnalysisView: View {
    // 1. Amati HomeViewModel yang dioper dari HomeView
    @ObservedObject var viewModel: HomeViewModel
    let onRetakeCompleted: () -> Void
    
    init(
        viewModel: HomeViewModel,
        onRetakeCompleted: @escaping () -> Void = {}
    ) {
        self.viewModel = viewModel
        self.onRetakeCompleted = onRetakeCompleted
    }
    
    // 2. Mengambil blueprint musiman yang teksnya cocok dengan hasil di Home
    private var analysis: ColorAnalysisModel {
        if let apiResult = viewModel.analysisResult {
            return ColorAnalysisModel.allSeasons.first {
                $0.seasonTitle.lowercased() == apiResult.colorType.lowercased()
            } ?? ColorAnalysisModel.dummy
        }
        return ColorAnalysisModel.dummy
    }
    
    // 3. Memperbaiki isi detail card Undertone, Skintone, Contrast secara dinamis dari API/Home
    private var dynamicInfos: [AnalysisInfoModel] {
        if let apiResult = viewModel.analysisResult {
            return [
                AnalysisInfoModel(title: "Undertone", value: apiResult.undertoneName),
                AnalysisInfoModel(title: "Skintone", value: apiResult.skintoneName),
                AnalysisInfoModel(title: "Contrast", value: apiResult.contrastName)
            ]
        }
        // Fallback ke data dummy jika data API belum di-load
        return analysis.infos
    }
    
    // Tambahkan di bawah 'private var dynamicInfos'
    private var dynamicBestColors: [ColorSwatchModel] {
        if let apiResult = viewModel.analysisResult {
            return apiResult.bestColors.map {
                ColorSwatchModel(title: $0.name, hex: $0.hex, color: Color(hex: $0.hex))
            }
        }
        return analysis.bestColors
    }

    private var dynamicAvoidColors: [ColorSwatchModel] {
        if let apiResult = viewModel.analysisResult {
            return apiResult.avoidColors.map {
                ColorSwatchModel(title: $0.name, hex: $0.hex, color: Color(hex: $0.hex))
            }
        }
        return analysis.avoidColors
    }
    
    
    var body: some View {
        // Hapus NavigationStack di sini karena sudah dibungkus oleh HomeView
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
//                    Text(analysis.seasonTitle)
//                        .font(.title3.weight(.semibold))
                    Text(viewModel.analysisResult?.colorType ?? analysis.seasonTitle.capitalized)
                        .font(.title3.weight(.semibold))
                    
                    NavigationLink {
                        OnboardingFlowView(
                            initialStep: .tutorial,
                            dismissOnCompletion: true
                        ) {
                            await viewModel.refreshAfterRetakeAnalysis()
                            onRetakeCompleted()
                        }
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
                    
                    Text("AI-generated analysis. Results may vary depending on lighting and image quality.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: .infinity)
                .padding(.trailing, 24)
                
                // MARK: - Analysis Cards (Menggunakan dynamicInfos agar isinya berubah)
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
                        }label: {
                            AnalysisInfoCard(
                                title: item.title,
                                value: item.value
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.trailing, 24)
                
//                // MARK: - Best Colors
//                ColorPaletteGrid(
//                    title: "Your Best Colors",
//                    colors: analysis.bestColors
//                )
//                
//                // MARK: - Avoid Colors
//                ColorPaletteGrid(
//                    title: "Avoid These Color",
//                    colors: analysis.avoidColors
//                )
                ColorPaletteGrid(title: "Your Best Colors", colors: dynamicBestColors)
                ColorPaletteGrid(title: "Avoid These Color", colors: dynamicAvoidColors)
            }
            .padding(.leading, 24)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
        // PERBAIKAN: Toolbar ditempelkan di dalam scope view hirarki agar tidak hilang
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ColorAnalysisSwitchView(
                        userPhotoData: viewModel.userPhoto
                    )
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ColorAnalysisView(viewModel: HomeViewModel())
}


