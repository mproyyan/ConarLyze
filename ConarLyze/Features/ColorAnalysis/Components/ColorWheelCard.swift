//
//  ColorWheelCard.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 24/05/26.
//

import SwiftUI

struct ColorWheelCard: View {
    
    let analysis: ColorAnalysisModel2
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
          
            Text(analysis.seasonTitle)
                .font(.title2.bold())
            
            SeasonWheelView(
                imageName: "fotoBunga",
                size: 200,
                colors: analysis.bestColors.map { $0.color }
            )
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    ColorWheelCard(
        analysis: ColorAnalysisModel2.allSeasons[0]
    )
}
