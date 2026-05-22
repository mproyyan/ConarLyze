//
//  ColorPaletteView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct ColorPaletteView: View {
    let colors: [Color]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(colors[index])
                    .frame(width: 30, height: 30)
            }
        }
    }
}

#Preview {
    ColorPaletteView(
        colors: OutfitDetailModel.dummy.colors
    )
}
