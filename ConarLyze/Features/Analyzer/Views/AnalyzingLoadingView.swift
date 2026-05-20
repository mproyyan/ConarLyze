//
//  AnalyzingLoadingView.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 20/05/26.
//


import SwiftUI

struct AnalyzingLoadingView: View {
  @State private var rotation: Double = 0
  @State private var sparkleScale: CGFloat = 1.0
  @State private var trimEnd: CGFloat = 0.0
  
  var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      
      VStack(spacing: 24) {
        Spacer()
        
        // Animated ring + sparkle icon
        ZStack {
          // Background ring (faint)
          Circle()
            .stroke(
              Color.orange.opacity(0.15),
              lineWidth: 4
            )
            .frame(width: 130, height: 130)
          
          // Animated gradient arc
          Circle()
            .trim(from: 0, to: trimEnd)
            .stroke(
              AngularGradient(
                gradient: Gradient(colors: [
                  Color.orange.opacity(0.3),
                  Color(red: 0.91, green: 0.41, blue: 0.13)
                ]),
                center: .center
              ),
              style: StrokeStyle(lineWidth: 4, lineCap: .round)
            )
            .frame(width: 130, height: 130)
            .rotationEffect(.degrees(-90))
            .rotationEffect(.degrees(rotation))
          
          // Sparkle icon
          SparkleIcon()
            .foregroundColor(Color(red: 0.91, green: 0.41, blue: 0.13))
            .frame(width: 44, height: 44)
            .scaleEffect(sparkleScale)
        }
        
        // Text
        VStack(spacing: 8) {
          Text("Analyzing your skin...")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.primary)
          
          Text("This may take a few seconds")
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.secondary)
        }
        
        Spacer()
      }
    }
    .onAppear {
      startAnimations()
    }
  }
  
  private func startAnimations() {
    // Arc trim animation
    withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
      trimEnd = 0.85
    }
    
    // Ring rotation
    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
      rotation = 360
    }
    
    // Sparkle pulse
    withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
      sparkleScale = 1.18
    }
  }
}

// MARK: - Sparkle Icon Shape

struct SparkleIcon: View {
  var body: some View {
    Canvas { context, size in
      let w = size.width
      let h = size.height
      let cx = w / 2
      let cy = h / 2
      
      // Large 4-point star
      let bigStar = largeStar(cx: cx, cy: cy, outerR: w * 0.42, innerR: w * 0.12)
      context.fill(bigStar, with: .foreground)
      
      // Small top-right star
      let smallStar = largeStar(cx: cx + w * 0.28, cy: cy - h * 0.28, outerR: w * 0.18, innerR: w * 0.06)
      context.fill(smallStar, with: .foreground)
    }
  }
  
  private func largeStar(cx: CGFloat, cy: CGFloat, outerR: CGFloat, innerR: CGFloat) -> Path {
    var path = Path()
    let points = 4
    for i in 0..<(points * 2) {
      let angle = Double(i) * .pi / Double(points) - .pi / 2
      let r = i.isMultiple(of: 2) ? outerR : innerR
      let x = cx + CGFloat(cos(angle)) * r
      let y = cy + CGFloat(sin(angle)) * r
      if i == 0 { path.move(to: CGPoint(x: x, y: y)) }
      else { path.addLine(to: CGPoint(x: x, y: y)) }
    }
    path.closeSubpath()
    return path
  }
}

// MARK: - Preview

#Preview("Loading") {
  AnalyzingLoadingView()
}
