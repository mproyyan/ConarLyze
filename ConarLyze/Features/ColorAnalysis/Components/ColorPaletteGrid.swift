//
//  ColorPaletteGrid.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct ColorPaletteGrid: View {
    let title: String
    let colors: [ColorSwatchModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.weight(.semibold))
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

#Preview {
    ColorPaletteGrid(
        title: "Best Colors",
        colors: ColorAnalysisModel.dummy.bestColors
    )
    .padding(.leading, 24)
}
