//
//  BrowseMoreButton.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct BrowseMoreButton: View {
    var body: some View {
        NavigationLink {
            OutfitDetailView()
            // ganti nanti dap
            // pake screen outfit list
        } label: {
            HStack(spacing: 12) {
                Text("Browse all 24 looks")
                Image(systemName: "chevron.right")
            }
            .font(.headline)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
//            .padding(.vertical, 20)
        }
    }
}

#Preview {
    BrowseMoreButton()
}
