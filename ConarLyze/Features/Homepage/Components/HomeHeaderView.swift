//
//  HomeHeaderView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var body: some View {
        
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Good Morning,")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text("Kevin")
                    .font(.largeTitle.bold())
            }
            Spacer()
            Button {
                // apa nyak
                // halaman profile
            } label: {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    HomeHeaderView().padding()
}
