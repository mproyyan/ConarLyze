//
//  ColorWheelCard.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 24/05/26.
//

import SwiftUI

struct ColorWheelCard: View {
    
    let analysis: ColorAnalysisModel
    let userPhotoData: Data?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
          
            Text(analysis.seasonTitle)
                .font(.title2.bold())
            
//            SeasonWheelView(
//                imageName: "fotoBunga",
//                size: 200,
//                colors: analysis.bestColors.map { $0.color }
//            )
            SeasonWheelView(
                imageName: "outfit-detail-image",
                imageData: userPhotoData,
                size: 200,
                colors: analysis.bestColors.map { $0.color }
            )
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    let dummyPhoto = UIImage(systemName: "person.crop.circle.fill")?.pngData()
    return ColorWheelCard(
        analysis: ColorAnalysisModel.allSeasons[0],
        userPhotoData: dummyPhoto
    )
}
