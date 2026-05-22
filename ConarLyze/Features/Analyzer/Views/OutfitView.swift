//
//  OutfitView.swift
//  ConarLyze
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

//
//  OutfitPage.swift
//  YourApp
//
//  Created by You
//

import SwiftUI

struct OutfitView: View {

    // GRID LAYOUT
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    // CATEGORY DATA
    let categories = [
        "All",
        "Casual",
        "Streetwear",
        "Smart Casual",
        "Minimalist"
    ]

    @State private var selectedCategory = "All"

    var body: some View {

        ZStack {

            // BACKGROUND
//            LinearGradient(
//                colors: [
//                    Color.black,
//                    Color(red: 0.08, green: 0.08, blue: 0.1)
//                ],
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 24) {

                    // HERO SECTION
                    HeroSection()

                    VStack(alignment: .leading, spacing: 20) {

                        // FILTER CHIPS
                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 10) {

                                ForEach(categories, id: \.self) { category in

                                    CategoryChip(
                                        title: category,
                                        selected: selectedCategory == category
                                    )
                                    .onTapGesture {
                                        selectedCategory = category
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // SECTION TITLE
//                        VStack(alignment: .leading, spacing: 6) {
//
//                            Text("Recommended Fits")
//                                .font(.title.bold())
//                                .foregroundColor(.primary)
//
//                            Text("Curated based on your undertone")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        .padding(.horizontal)

                        // GRID
                        LazyVGrid(columns: columns, spacing: 18) {

                            ForEach(0..<8) { item in

                                OutfitCard()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    OutfitView()
}






// MARK: - HERO SECTION

struct HeroSection: View {

    var body: some View {

        ZStack(alignment: .bottomLeading) {

            // IMAGE
            Image("fashionBanner")
                .resizable()
                .scaledToFill()
                .frame(height: 360)
                .frame(maxWidth: .infinity)
                .clipped()
                
            // OVERLAY
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.4),
                    .black.opacity(0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // CONTENT
            VStack(alignment: .leading, spacing: 12) {

                Text("CLASSIC STYLE")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Earth Essentials")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.white)

                Text("Grounded tones and effortless layers designed for a calm, natural look.")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Button {

                } label: {

                    HStack {

                        Image(systemName: "sparkles")

                        Text("Explore Styles")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .clipShape(Capsule())
                }
                .padding(.top, 6)
            }
            .padding()
        }
        .frame(height: 360)
        
        
    }
}






// MARK: - OUTFIT CARD

struct OutfitCard: View {

    var body: some View {

        ZStack(alignment: .bottomLeading) {

            // IMAGE
            Image("outfit")
                .resizable()
                .scaledToFill()
                .frame(height: 260)
                .frame(maxWidth: .infinity)
                .clipped()

            // GRADIENT
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.85)
                ],
                startPoint: .center,
                endPoint: .bottom
            )

            // CONTENT
            VStack(alignment: .leading, spacing: 8) {

                Text("Soft Neutrals")
                    .font(.headline.bold())
                    .foregroundColor(.white)

                Text("Minimal Earthy")
                    .font(.caption)
                    .foregroundColor(.gray)

                // COLOR PALETTE
                HStack(spacing: 6) {

                    PaletteCircle(color: Color(hex: "#6B4F3A"))

                    PaletteCircle(color: Color(hex: "#A67B5B"))

                    PaletteCircle(color: Color(hex: "#D8C3A5"))

                    PaletteCircle(color: Color(hex: "#EAE0D5"))
                }
            }
            .padding()
        }
        .frame(height: 260)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}






// MARK: - CATEGORY CHIP

struct CategoryChip: View {

    var title: String
    var selected: Bool

    var body: some View {

        Text(title)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                selected ?
                Color.secondary :
                Color.secondary.opacity(0.2)
            )
            .clipShape(Capsule())
    }
}






// MARK: - PALETTE CIRCLE

struct PaletteCircle: View {

    var color: Color

    var body: some View {

        Circle()
            .fill(color)
            .frame(width: 14, height: 14)
    }
}








