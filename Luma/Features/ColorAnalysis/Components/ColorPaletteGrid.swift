//
//  ColorPaletteGrid.swift
//  Luma
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct ColorPaletteGrid: View {
    let title: String
    let colors: [ColorSwatchModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title3.weight(.semibold))
                
                Text(title.lowercased().contains("avoid") ? "Colors in this spectrum may appear too bright, warm, or overpowering against your natural coloring." : "Colors in this spectrum naturally complement your features and create a more balanced, harmonious look.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.trailing, 24)
            
          VStack(spacing: 16) {
            VStack(spacing: 12) {
              Text(title.lowercased().contains("avoid") ? "Color spectrum to avoid" : "Your best color spectrum")
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
              
              LinearGradient(
                colors: colors.map(\.color),
                startPoint: .leading,
                endPoint: .trailing
              )
              .frame(height: 48)
              .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.trailing, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 12) {
                ForEach(colors) { item in
                  ColorSwatchCard(
                    title: item.title,
                    hex: item.hex,
                    color: item.color
                  )
                }
              }
              .padding(.trailing, 24)
            }
          }
        }
    }
}

#Preview {
    ColorPaletteGrid(
        title: "Best Colors",
        colors: ColorAnalysisModel.dummy.bestColors
    )
    .padding(.leading, 24)
}
