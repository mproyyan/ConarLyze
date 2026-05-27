//
//  ColorSwatchCard.swift
//  Luma
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct ColorSwatchCard: View {
    let title: String
    let hex: String
    let color: Color
    
    private let cardWidth: CGFloat = 72
    private let cardHeight: CGFloat = 140
    private let cornerRadius: CGFloat = 16
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                
                Text(hex)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
    }
}

#Preview {
    HStack {
        ColorSwatchCard(
            title: "Dark Blue",
            hex: "#111827",
            color: .blue
        )
        
        ColorSwatchCard(
            title: "dusty neutral gray",
            hex: "#A0A098",
            color: .gray
        )
        
        ColorSwatchCard(
            title: "bright saturated blue",
            hex: "#1060C0",
            color: .cyan
        )
    }
    .padding()
}
