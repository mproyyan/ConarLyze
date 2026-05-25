//
//  FashionIdeaCard.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct FashionIdeaCard: View {
    let item: FashionIdeaModel
    
    var body: some View {
        
        HStack(spacing: 16) {
            Image("outfit")
                .resizable()
                .scaledToFill()
                .frame(width: 112, height: 168)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                Text(item.title)
                    .font(.headline.weight(.semibold))
                ColorPaletteView(
                    colors: item.colors
                )
                Text(item.style)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 28)
        )
//        .shadow(
//            color: .black.opacity(0.04),
//            radius: 16,
//            y: 6
//        )
    }
}

#Preview {
    FashionIdeaCard(
        item: FashionIdeaModel.dummy[0]
    )
}
