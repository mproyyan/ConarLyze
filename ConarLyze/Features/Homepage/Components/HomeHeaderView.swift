//
//  HomeHeaderView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct HomeHeaderView: View {
    let userName: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(greetingText)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(userName)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            Button {
                // TODO: Navigate to profile page
            } label: {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                    .foregroundStyle(.primary)
            }
        }
    }
    
    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good Morning,"
        case 12..<17:
            return "Good Afternoon,"
        case 17..<21:
            return "Good Evening,"
        default:
            return "Good Night,"
        }
    }
}

#Preview {
    HomeHeaderView(userName: "Daffa")
        .padding()
}
