//
//  OutfitHeaderView.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct OutfitHeaderView: View {
    let title: String
    let colors: [Color]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.capitalized)
                .font(.title3.bold())
            ColorPaletteView(colors: colors)
        }
    }
}

#Preview {
    OutfitHeaderView(
        title: "Soft Neutrals",
        colors: OutfitDetailModel.dummy.colors
    )
}
