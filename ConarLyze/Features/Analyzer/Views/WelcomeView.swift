//
//  WelcomeView.swift
//  ConarLyze
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            GeometryReader{ geo in
                Image("welcomePage")
                    .resizable()
                    .scaledToFill()
                    .offset(x:-70)
                    .ignoresSafeArea()
            }

            
            // Dark Gradient Overlay
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.8)
                ],
                startPoint: .center,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Bottom Content
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Welcome to ConarLyze")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Text("Analyze your color skin type without hesitate")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }
                
                // Button
                Button(action:{}) {
                    Text("Start")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.primaryColor.opacity(0.8))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(
                                    LinearGradient(
                                        colors: [.white.opacity(0.4), .clear, .white.opacity(0.1)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        )
                        .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 10)
                        
                        
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    WelcomeView()
}
