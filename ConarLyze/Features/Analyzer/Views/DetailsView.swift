//
//  EditColorType.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

import SwiftUI

struct DetailsView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
       
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 16){
                    
                    
                    Text("Cool to Neutral Cool")
                        .font(.title2.bold())
                        .padding(.top, 20)
                    Text("Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
                    
                    
                    
                    
                }
                VStack(alignment: .leading, spacing: 16){
                    Text("What is Undertone ?")
                        .font(.title2.bold())
                    
                    DescriptionCard(description: "Undertone is the subtle hue beneath your skin's surface that doesn't change with sun exposure or seasons.")
                }
    
                
                Spacer()
                
            }
        

            .navigationTitle("Undertone")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if !path.isEmpty { path.removeLast() }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding(.horizontal, 16)

        
           
           
    }
}

#Preview {
    let constantPath = Binding.constant(NavigationPath())
    return NavigationStack(path: constantPath) {
        DetailsView(path: constantPath)
    }
}
