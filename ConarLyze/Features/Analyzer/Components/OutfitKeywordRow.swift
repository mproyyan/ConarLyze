//
//  OutfitKeywordRow.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct OutfitKeywordRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color.primaryColor)
                .frame(width: 36)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineSpacing(2)
//                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
    }
}

#Preview {
    OutfitKeywordRow(
        icon: "tshirt",
        title: "Tops",
        description: "White Polo, Beige Knit, Navy Tee"
    )
}
