//
//  InformationCard.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 22/05/26.
//

import SwiftUI

struct InformationCard: View {
    var body: some View {
        VStack(){
            Label("Analysis results may vary depending on lighting, camera quality, and surrounding color conditions.", systemImage: "lightbulb.max")
                .foregroundStyle(.orange)
                .font(.subheadline)
                .padding(10)
                .foregroundColor(.primary)
                .background(.secondary.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

#Preview {
    InformationCard()
}


