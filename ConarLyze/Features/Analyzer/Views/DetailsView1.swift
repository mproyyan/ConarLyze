//
//  DetailsView.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

import SwiftUI

struct DetailsView1: View {
        @State var headline = ""
        let title: String
        let subtitle: String
        let description: String
        let accentColor: Color
        
        var body: some View {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: TOP BAR
                    
                    HStack {
                        
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.black)
                                .frame(width: 42, height: 42)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.06), radius: 8)
                        }
                        
                        Spacer()
                        
                        Text("Undertone")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Color.clear
                            .frame(width: 42)
                    }
                    .padding(.horizontal)
                    
                    
                    // MARK: HERO
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        RoundedRectangle(cornerRadius: 32)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        accentColor.opacity(0.35),
                                        .white
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 220)
                            .overlay(alignment: .bottomLeading) {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(title)
                                        .font(.system(size: 30, weight: .bold))
                                    
                                    Text(subtitle)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(26)
                            }
                    }
                    .padding(.horizontal)
                    
                    
                    // MARK: DESCRIPTION
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("About Your Result")
                            .font(.title3.bold())
                        
                        Text(description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .lineSpacing(6)
                    }
                    .padding(22)
                    .background(.white.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .overlay {
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(.white.opacity(0.7), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.05), radius: 12, y: 5)
                    .padding(.horizontal)
                    
                    
//                    // MARK: PALETTE
//                    
//                    VStack(alignment: .leading, spacing: 16) {
//                        
//                        Text("Recommended Palette")
//                            .font(.title3.bold())
//                        
//                        HStack(spacing: 14) {
//                            
//                            RoundedRectangle(cornerRadius: 18)
//                                .fill(accentColor)
//                            
//                            RoundedRectangle(cornerRadius: 18)
//                                .fill(accentColor.opacity(0.8))
//                            
//                            RoundedRectangle(cornerRadius: 18)
//                                .fill(accentColor.opacity(0.6))
//                            
//                            RoundedRectangle(cornerRadius: 18)
//                                .fill(accentColor.opacity(0.4))
//                        }
//                        .frame(height: 90)
//                    }
//                    .padding(.horizontal)
                }
                .padding(.top)
                .padding(.bottom, 40)
            }
            .background(Color(hex: "#F7F7F5"))
        }
    }

#Preview {
    
    DetailsView1(
        title: "Cool Neutral Undertone",
        subtitle: "Balanced cool pigments with soft natural neutrality.",
        description: "Your complexion harmonizes best with cool and muted tones. Soft blues, dusty roses, and silver-based shades naturally complement your appearance while maintaining a calm and elegant balance.",
        accentColor: Color(hex: "#20b2aa")
    )
}




