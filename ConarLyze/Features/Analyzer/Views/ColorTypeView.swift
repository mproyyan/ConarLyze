//
//  ResultDescriptionView.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

//import SwiftUI
//
//struct ResultDescriptionView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    ResultDescriptionView()
//}
//
//  ColorTypeView.swift
//  ConarLyze
//

import SwiftUI

struct ColorTypeView: View {
    
    let colors: [Color] = [
        Color(hex: "#6F8FAF"),
        Color(hex: "#B57C8A"),
        Color(hex: "#A9A06A"),
        Color(hex: "#6DAA8A"),
        Color(hex: "#6C7BA8"),
        Color(hex: "#8A73A8")
    ]
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 28) {
                
                // MARK: HEADER
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text("Your Color Identity")
                            .font(.system(size: 34, weight: .bold))
                        
                        Text("Soft Summer Profile")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 48, height: 48)
                            .background(.white.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.06), radius: 12)
                    }
                }
                .padding(.horizontal)
                
                
                // MARK: HERO SECTION
                
                VStack(spacing: 18) {
                    
                    ZStack {
                        
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color.pink.opacity(0.15),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: 130
                                )
                            )
                            .frame(width: 260, height: 260)
                        
                        ColorWheelView()
                        
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 78, height: 78)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.white, lineWidth: 4)
                            }
                    }
                    
                    VStack(spacing: 6) {
                        
                        Text("Soft Summer")
                            .font(.system(size: 30, weight: .bold))
                        
                        Text("Muted • Cool • Elegant")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("Calm, refined, and effortlessly soft.")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                
                
                // MARK: INSIGHT CARDS
                
                VStack(spacing: 16) {
                    
                    InsightCard(
                        title: "Undertone",
                        subtitle: "Cool to Neutral Cool",
                        iconColor: Color(hex: "#C07A85")
                    )
                    
                    InsightCard(
                        title: "Skintone",
                        subtitle: "Soft & Muted",
                        iconColor: Color(hex: "#D9D4CF")
                    )
                    
                    InsightCard(
                        title: "Contrast",
                        subtitle: "Low Contrast",
                        iconColor: Color(hex: "#B98A95")
                    )
                }
                .padding(.horizontal)
                
                
                // MARK: BEST COLORS
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Your Best Colors")
                        .font(.system(size: 24, weight: .bold))
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        
                        ColorCard(
                            color: Color(hex: "#111827"),
                            title: "Dark Navy",
                            subtitle: "Elegant depth"
                        )
                        
                        ColorCard(
                            color: Color(hex: "#274690"),
                            title: "Royal Blue",
                            subtitle: "Cool confidence"
                        )
                        
                        ColorCard(
                            color: Color(hex: "#4A90FF"),
                            title: "Sky Blue",
                            subtitle: "Fresh softness"
                        )
                        
                        ColorCard(
                            color: Color(hex: "#C7D4EB"),
                            title: "Powder Blue",
                            subtitle: "Gentle balance"
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .padding(.bottom, 40)
        }
        .background(Color(hex: "#F7F7F5"))
    }
}

#Preview {
    ColorTypeView()
}

//
//  ColorWheelView.swift
//

import SwiftUI

struct ColorWheelView: View {
    
    let colors: [Color] = [
        Color(hex: "#B57C8A"),
        Color(hex: "#6F8FAF"),
        Color(hex: "#B0A06D"),
        Color(hex: "#C48A92"),
        Color(hex: "#8A73A8"),
        Color(hex: "#6DAA8A")
    ]
    
    var body: some View {
        
        ZStack {
            
            ForEach(0..<6) { index in
                
                Circle()
                    .trim(from: 0.0, to: 0.16)
                    .stroke(
                        colors[index],
                        style: StrokeStyle(
                            lineWidth: 54,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(Double(index) * 60))
            }
        }
        .frame(width: 190, height: 190)
    }
}
//
//  InsightCard.swift
//

struct InsightCard: View {
    
    let title: String
    let subtitle: String
    let iconColor: Color
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            Circle()
                .fill(iconColor)
                .frame(width: 14, height: 14)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding(22)
        .background(.white.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white.opacity(0.6), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.05), radius: 14, y: 6)
    }
}



struct ColorCard: View {
    
    let color: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 24)
            .fill(color)
            .frame(height: 160)
            .overlay(alignment: .bottomLeading) {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(16)
            }
    }
}
