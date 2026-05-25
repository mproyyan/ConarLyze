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
                title:"Undertone",
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
        
        .frame(maxWidth:.infinity)
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
        case darkWinter
        case trueWinter
        case brightWinter
        case clearSpring
        case warmSpring
        case lightSpring
        case lightSummer
        case coolSummer
        case softSummer
        case softAutumn
        case warmAutumn
        case deepAutumn
        var title: String {
          switch self {
          case .darkWinter:
            return "Dark Winter"
          case .trueWinter:
            return "True Winter"
          case .brightWinter:
            return "Bright Winter"
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
            return "warm Autumn"
          case .deepAutumn:
            return "Deep Autumn"
          }
        }
        var backgroundImageName: String {
          switch self {
          case .darkWinter:
            return "darkWinter"
          case .trueWinter:
            return "trueWinter"
          case .brightWinter:
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
          case .softSummer:
            return "Cool to Neutral"
          case .warmSpring, .deepAutumn:
            return "Warm"
          default:
            return "Cool"
          }
        }
        
        var skintone: String {
          switch self {
          case .softSummer:
            return "Soft & Muted"
          default:
            return "Balanced"
          }
        }
        
        var contrast: String {
          switch self {
          case .softSummer:
            return "Low"
          case .darkWinter, .brightWinter:
            return "High"
          default:
            return "Medium"
          }
        }
      }
    
    let cardType: CardType
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
                VStack (spacing:0) {
                    Spacer()
                    SeasonWheelView(imageName: "outfit-detail-image", size: 120)
                        .padding(.top,8)
                        .padding(.bottom,8)
                        
                    VStack(spacing: 2) {
                      Text("Your Color Type")
                        .font(.system(size: 18, weight: .bold))
                      
                      Text(cardType.title)
                        .font(.system(size: 38, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,16)
                    .padding(.bottom,16)
                    VStack(spacing: 0) {
                        AnalyzeTraitBar (
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
    AnalyzeCard(cardType: .clearSpring)
        .padding(.horizontal,20)
        .frame(width:380)
}
