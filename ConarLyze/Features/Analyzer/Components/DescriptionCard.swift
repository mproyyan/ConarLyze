//
//  DescriptionCard.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 22/05/26.
//

import SwiftUI

struct DescriptionCard: View {
//    let heading: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
              //  .font(.subheadline)
               
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    DescriptionCard(
        description: "Undertone is the subtle hue beneath your skin's surface that doesn't change with sun exposure or seasons."
    )
}
