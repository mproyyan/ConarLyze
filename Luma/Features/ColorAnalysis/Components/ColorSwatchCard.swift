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
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(color)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                
                Text(hex)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(.horizontal, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .background(Color.black.opacity(0.85))
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.white.opacity(0.3)),
                alignment: .top
            )
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color.black.opacity(0.15), lineWidth: 1)
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
