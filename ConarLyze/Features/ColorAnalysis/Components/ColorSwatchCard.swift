//
//  ColorSwatchCard.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct ColorSwatchCard: View {
    let title: String
    let hex: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(height: 90)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white)
                Text(hex)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .frame(width: 72)
        .background(color)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    ColorSwatchCard(
        title: "Dark Blue",
        hex: "#111827",
        color: .blue
    )
}
