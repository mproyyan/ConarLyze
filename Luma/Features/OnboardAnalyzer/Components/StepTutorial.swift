//
//  StepTutorial.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//

import SwiftUI

struct StepTutorial: View {
  var icon: String
  var title: String
  var description: String
  
  var body: some View {
    HStack(spacing: 24) {
      Image(systemName: icon)
          .font(.system(size: 32))
          .foregroundColor(Color.primaryColor)
          .frame(width: 40, height: 40, alignment: .center)
      
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .font(.system(size: 17))
          .fontWeight(.semibold)
        
        Text(description)
          .font(.system(size: 11))
          .foregroundStyle(Color.secondary)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  StepTutorial(icon: "camera.aperture", title: "Claen camera lens", description: "Wipe your camera to make sure your photo is clear and sharp.")
}
