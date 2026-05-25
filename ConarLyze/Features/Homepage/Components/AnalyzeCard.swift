//
//  AnalyzeCard.swift
//  ConarLyze
//
//  Created by Saifulloh Rahman on 21/05/26.
//

import SwiftUI

private struct AnalyzeTraitBar: View {
    let undertone: String
    let skintone: String
    let contrast: String
    
    var body: some View {
        HStack(spacing: 0) {
            AnalyzeTraitItem(
                title: "Undertone",
                value: undertone
            )
            
            Divider()
                .background(.white.opacity(1))
            
            AnalyzeTraitItem(
                title: "Skintone",
                value: skintone
            )
            
            Divider()
                .background(.white.opacity(1))
            
            AnalyzeTraitItem(
                title: "Contrast",
                value: contrast
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: 64)
    }
    
    private struct AnalyzeTraitItem: View {
        let title: String
        let value: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 14))
                
                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct AnalyzeCard: View {
    
    enum CardType {
        case deepWinter
        case coolWinter
        case clearWinter
        
        case clearSpring
        case warmSpring
        case lightSpring
        
        case lightSummer
        case coolSummer
        case softSummer
        
        case softAutumn
        case warmAutumn
        case deepAutumn
        
        // MARK: - Backend Mapping
        
        static func from(colorType: String) -> CardType {
            let normalized = colorType
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: "_", with: " ")
                .replacingOccurrences(of: "-", with: " ")
            
            switch normalized {
            // Winter
            case "dark winter", "deep winter":
                return .deepWinter
                
            case "true winter", "cool winter":
                return .coolWinter
                
            case "bright winter", "clear winter":
                return .clearWinter
                
            // Spring
            case "clear spring", "bright spring":
                return .clearSpring
                
            case "warm spring", "true spring":
                return .warmSpring
                
            case "light spring":
                return .lightSpring
                
            // Summer
            case "light summer":
                return .lightSummer
                
            case "cool summer", "true summer":
                return .coolSummer
                
            case "soft summer":
                return .softSummer
                
            // Autumn
            case "soft autumn":
                return .softAutumn
                
            case "warm autumn", "true autumn":
                return .warmAutumn
                
            case "deep autumn", "dark autumn":
                return .deepAutumn
                
            default:
                return .softSummer
            }
        }
        
        // MARK: - Display Data
        
        var title: String {
            switch self {
            case .deepWinter:
                return "Deep Winter"
            case .coolWinter:
                return "Cool Winter"
            case .clearWinter:
                return "Clear Winter"
            case .clearSpring:
                return "Clear Spring"
            case .warmSpring:
                return "Warm Spring"
            case .lightSpring:
                return "Light Spring"
            case .lightSummer:
                return "Light Summer"
            case .coolSummer:
                return "Cool Summer"
            case .softSummer:
                return "Soft Summer"
            case .softAutumn:
                return "Soft Autumn"
            case .warmAutumn:
                return "Warm Autumn"
            case .deepAutumn:
                return "Deep Autumn"
            }
        }
        
        var backgroundImageName: String {
            switch self {
            case .deepWinter:
                return "darkWinter"
            case .coolWinter:
                return "trueWinter"
            case .clearWinter:
                return "brightWinter"
            case .clearSpring:
                return "clearSpring"
            case .warmSpring:
                return "warmSpring"
            case .lightSpring:
                return "lightSpring"
            case .lightSummer:
                return "lightSummer"
            case .coolSummer:
                return "coolSummer"
            case .softSummer:
                return "softSummer"
            case .softAutumn:
                return "clearAutumn"
            case .warmAutumn:
                return "coolAutumn"
            case .deepAutumn:
                return "deepAutumn"
            }
        }
        
        var undertone: String {
            switch self {
            case .warmSpring, .warmAutumn, .deepAutumn, .softAutumn:
                return "Warm"
                
            case .deepWinter, .coolWinter, .clearWinter,
                 .lightSummer, .coolSummer, .softSummer:
                return "Cool"
                
            case .clearSpring, .lightSpring:
                return "Warm"
            }
        }
        
        var skintone: String {
            switch self {
            case .lightSpring, .lightSummer:
                return "Light"
                
            case .softSummer, .softAutumn:
                return "Soft"
                
            case .deepWinter, .deepAutumn:
                return "Deep"
                
            default:
                return "Balanced"
            }
        }
        
        var contrast: String {
            switch self {
            case .deepWinter, .clearWinter, .clearSpring, .deepAutumn:
                return "High"
                
            case .softSummer, .softAutumn, .lightSummer, .lightSpring:
                return "Low"
                
            default:
                return "Medium"
            }
        }
    }
    
    let cardType: CardType
    var bestColors: [Color]? = nil
    var userPhotoData: Data? = nil
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(cardType.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                    .clipped()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    if let bestColors = bestColors, !bestColors.isEmpty {
                        SeasonWheelView(
                            imageName: "outfit-detail-image",
                            imageData: userPhotoData,
                            size: 120,
                            colors: bestColors
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    } else {
                        SeasonWheelView(
                            imageName: "outfit-detail-image",
                            imageData: userPhotoData,
                            size: 120
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                    
                    VStack(spacing: 2) {
                        Text("Your Color Type")
                            .font(.system(size: 18, weight: .bold))
                        
                        Text(cardType.title)
                            .font(.system(size: 38, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    VStack(spacing: 0) {
                        AnalyzeTraitBar(
                            undertone: cardType.undertone,
                            skintone: cardType.skintone,
                            contrast: cardType.contrast
                        )
                        
                        HStack(spacing: 8) {
                            Text("View full analysis")
                                .font(.system(size: 16, weight: .bold))
                                .lineLimit(1)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .overlay(alignment: .top) {
                            Rectangle()
                                .fill(.white.opacity(0.45))
                                .frame(height: 1)
                        }
                    }
                    .background(.ultraThinMaterial)
                    .background(.black.opacity(0.22))
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(.white.opacity(0.45))
                            .frame(height: 1)
                    }
                }
            }
        }
        .frame(height: 330)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    AnalyzeCard(
        cardType: AnalyzeCard.CardType.from(colorType: "Deep Winter")
    )
    .padding(.horizontal, 20)
    .frame(width: 380)
}
