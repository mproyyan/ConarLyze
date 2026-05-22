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
                title:"undertone",
                value: undertone
            )
            Divider()
                .background(.white.opacity(0.7))

            AnalyzeTraitItem(
                title: "Skintone",
                value: skintone
            )

            Divider()
                .background(.white.opacity(0.7))

            AnalyzeTraitItem(
                title: "Contrast",
                value: contrast
            )
        }
        
        .frame(maxWidth:.infinity)
        .frame(height: 72)
//        .background(.ultraThinMaterial)
//        .background(.white.opacity(0.12))
    }
    private struct AnalyzeTraitItem: View {
        let title: String
        let value: String

        var body: some View {
            VStack(alignment: .center, spacing: 4) {
                Text(title)
                    .font(.system(size: 14))

                Text(value)
                    .font(.system(size: 16, weight: .bold))
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
                        )
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                VStack (spacing:0) {
                    Spacer()
                    Circle()
                        .fill(.white .opacity(0.25))
                        .frame(width:90, height:90)
                        .padding(.top,24)
                    VStack(spacing: 4) {
                      Text("Your Color Type")
                        .font(.system(size: 18, weight: .bold))
                      
                      Text(cardType.title)
                        .font(.system(size: 46, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,16)
                    .padding(.bottom,16)
                    VStack(spacing: 0) {
                        AnalyzeTraitBar(
                            undertone: cardType.undertone,
                            skintone: cardType.skintone,
                            contrast: cardType.contrast
                        )

                        Button {
                        } label: {
                            HStack(spacing: 10) {
                                Text("View full analysis")
                                    .font(.system(size: 16, weight: .bold))
                                    .lineLimit(1)

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                        }
                        .overlay(alignment: .top) {
                            Rectangle()
                                .fill(.white.opacity(0.45))
                                .frame(height: 1)
                        }
                    }
                    .glassEffect(.regular, in: .rect(cornerRadius: 0))
                    .background(
                        LinearGradient(
                            colors: [
                                .black.opacity(0.18),
                                .black.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(alignment: .top) {
                      Rectangle()
                        .fill(.white.opacity(0.45))
                        .frame(height: 1)
                        }
                    
                    }
                
                }
            .frame(height: 330)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        }
        

#Preview {
    AnalyzeCard(cardType: .deepAutumn)
        .padding(.horizontal,20)
        .frame(width:380)
}
