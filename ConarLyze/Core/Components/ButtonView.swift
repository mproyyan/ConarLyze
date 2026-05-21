//
//  ButtonView.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//

import SwiftUI

struct ButtonView: View {
  var text: String
  
  var body: some View {
    Text(text)
      .fontWeight(.semibold)
      .foregroundColor(.white)
      .padding(.vertical, 12)
      .frame(maxWidth: .infinity)
      .background(Color.primaryColor)
      .cornerRadius(60)
  }
}

#Preview {
  ButtonView(text: "Next")
}
