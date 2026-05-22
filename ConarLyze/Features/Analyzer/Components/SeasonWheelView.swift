//
//  SeasonWheelView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct SeasonWheelView: View {
    let imageName: String
    let size: CGFloat
    
    private let innerRadiusRatio: CGFloat = 0.30
    
    private var centerImageSize: CGFloat {
        size * 0.38
    }
    
    private let colors: [Color] = [
        Color(red: 0.45, green: 0.63, blue: 0.67), // teal
        Color(red: 0.64, green: 0.60, blue: 0.40), // khaki
        Color(red: 0.72, green: 0.43, blue: 0.47), // rose
        Color(red: 0.44, green: 0.38, blue: 0.65), // purple
        Color(red: 0.42, green: 0.49, blue: 0.67), // blue
        Color(red: 0.43, green: 0.64, blue: 0.47), // green
        Color(red: 0.64, green: 0.65, blue: 0.43), // olive
        Color(red: 0.64, green: 0.43, blue: 0.57)  // mauve
    ]
    
    var body: some View {
        ZStack {
            ForEach(colors.indices, id: \.self) { index in
                WheelSegment(
                    startAngle: angle(for: index),
                    endAngle: angle(for: index + 1),
                    innerRadiusRatio: innerRadiusRatio
                )
                .fill(colors[index])
                .overlay {
                    WheelSegment(
                        startAngle: angle(for: index),
                        endAngle: angle(for: index + 1),
                        innerRadiusRatio: innerRadiusRatio
                    )
                    .stroke(Color.white, lineWidth: 4)
                }
            }
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: centerImageSize, height: centerImageSize)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                }
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
        .frame(width: size, height: size)
    }
    
    private func angle(for index: Int) -> Angle {
        .degrees(Double(index) * 45 - 90)
    }
}

struct WheelSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadiusRatio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio
        
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    SeasonWheelView(
        imageName: "fotoBunga",
        size: 300
    )
}
