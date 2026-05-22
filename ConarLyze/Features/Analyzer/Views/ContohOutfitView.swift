//
//  ContohOutfitView.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

import SwiftUI

struct ContohOutfitView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.backward")
                    }
                    
                    VStack(alignment: .leading){
                        Text("Casual")
                            .font(.headline)
                        Text("Earthy Essential ")
                            .font(.largeTitle.bold())
                        Text("Grounded tones and effortless layers designed for a calm, natural look.")
                        
                        
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContohOutfitView()
}
