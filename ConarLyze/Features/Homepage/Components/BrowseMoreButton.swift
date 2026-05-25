//
//  BrowseMoreButton.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct BrowseMoreButton: View {
    let totalLooks: Int
    
    var body: some View {
        HStack(spacing: 12) {
            Text("Browse all \(totalLooks) looks")
            
            Image(systemName: "chevron.right")
        }
        .font(.headline)
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BrowseMoreButton(totalLooks: 112)
}
