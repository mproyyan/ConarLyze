//
//  SeasonWheelView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct SeasonWheelView: View {
    
    // MARK: - Properties
    let size: CGFloat
    
    // MARK: - Init
    init(size: CGFloat = 140) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Image("season-wheel")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        SeasonWheelView()
        SeasonWheelView(size: 180)
        SeasonWheelView(size: 240)
    }
}


