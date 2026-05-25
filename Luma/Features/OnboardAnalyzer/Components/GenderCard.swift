//
//  GenderCard.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI

struct GenderCard: View {
  let title: String
  let icon: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      VStack(spacing: 12) {
        Image(systemName: icon)
          .font(.system(size: 32))
        
        Text(title)
          .fontWeight(.semibold)
      }
      .foregroundColor(isSelected ? .white : .primary)
      .frame(maxWidth: .infinity)
      .frame(height: 140)
      .background(
        isSelected
        ? Color.primaryColor
        : Color.gray.opacity(0.15)
      )
      .cornerRadius(20)
    }
  }
}

#Preview {
    GenderCard(
      title: "Male",
      icon: "person.fill",
      isSelected: false,
      action: { }
    )
}
