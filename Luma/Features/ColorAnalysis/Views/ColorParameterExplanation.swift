//
//  EditColorType.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

import SwiftUI

struct ColorParameterExplanation: View {
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20){
      VStack(alignment: .leading, spacing: 16){
        Text("What is Undertone?")
          .font(.title2.bold())
          .padding(.top, 20)
        
        Text("Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
      }
      
      VStack(alignment: .leading, spacing: 16){
        Text("How about your undertone?")
          .font(.title2.bold())
          .padding(.top, 20)
        
        Text("Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
      }
      
      Spacer()
      
    }
    
    
    .navigationTitle("Undertone")
    .navigationBarTitleDisplayMode(.inline)
    .padding(.horizontal, 16)
    
    
    
    
  }
}

#Preview {
  ColorParameterExplanation()
}
