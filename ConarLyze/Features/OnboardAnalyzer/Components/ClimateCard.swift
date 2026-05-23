//
//  ClimateCard.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI

struct ClimateCard: View {
  var title: String
  var icon: String
  var value: String = "?"
  
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: icon)
        .font(.system(size: 35))
      
      Text(title)
      
      Text(value)
        .font(.system(size: 25))
        .fontWeight(.bold)
    }
    .frame(height: 150)
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.15))
    .cornerRadius(10)
  }
}

#Preview {
  ClimateCard(title: "Humidity", icon: "humidity", value: "60%")
}
