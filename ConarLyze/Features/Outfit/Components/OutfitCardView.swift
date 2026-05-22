//
//  OutfitCardView.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 22/05/26.
//

import SwiftUI

struct OutfitCardView: View {
    let imageName: String
    let title: String
    let colors: [Color]
    
    private let cardWidth: CGFloat = 177
    private let cardHeight: CGFloat = 254.25
    private let cornerRadius: CGFloat = 15
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipped()
            
            LinearGradient(
                colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.75)
                ],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(width: cardWidth, height: cardHeight)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    ForEach(colors.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(colors[index])
                            .frame(width: 20, height: 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 18)
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
        .contentShape(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
    }
}

#Preview {
    OutfitCardView(
        imageName: "outfit-detail-image",
        title: "Soft Neutrals",
        colors: OutfitDetailModel.dummy.colors
    )
}
