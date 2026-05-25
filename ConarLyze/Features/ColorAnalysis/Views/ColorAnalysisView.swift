//
//  ColorAnalysisView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct ColorAnalysisView: View {
  private let analysis = ColorAnalysisModel.dummy
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 24) {
          // MARK: - Header
          HStack {
            VStack(alignment: .leading, spacing: 4) {
              Text("Your Color Season")
                .font(.title.bold())
              Text("Personal color analysis")
              // Bingung text nya
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            Spacer()
          }
          .padding(.trailing, 24)
          
          // MARK: - Season Wheel
          VStack(spacing: 8) {
            SeasonWheelView(imageName: "outfit-detail-image", size: 260)
            Text(analysis.seasonTitle)
              .font(.title3.weight(.semibold))
            NavigationLink {
              CameraView()
            } label: {
              HStack(spacing: 8) {
                Image(systemName: "camera")
                Text("Retake Analysis")
              }
              .font(.subheadline.weight(.medium))
              .foregroundStyle(Color.primaryColor)
              .padding(.horizontal, 16)
              .padding(.vertical, 10)
              .background(
                Color.primaryColor.opacity(0.08)
              )
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
          
          // MARK: - Analysis
          VStack(spacing: 12) {
            ForEach(analysis.infos) { item in
              
              NavigationLink {
                ColorParameterExplanation()
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
          
          // MARK: - Best Colors
          
          ColorPaletteGrid(
            title: "Your Best Colors",
            colors: analysis.bestColors
          )
          // MARK: - Avoid Colors
          
          ColorPaletteGrid(
            title: "Avoid These Color",
            colors: analysis.avoidColors
          )
        }
        .padding(.leading, 24)
        .padding(.top, 16)
        .padding(.bottom, 40)
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        NavigationLink {
          ColorAnalysisSwitchView()
          // ganti pake halaman select manual palette
        } label: {
          
          Image(systemName: "square.and.pencil")
            .font(.headline)
            .foregroundStyle(.black)
        }
      }
    }
    .background(
      Color(.systemGroupedBackground)
    )
  }
}

#Preview {
  ColorAnalysisView()
}
