//
//  OutfitDetailView.swift
//  Luma
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI
import FoundationModels

struct OutfitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var whyItWorksText: String = "Analyzing outfit harmony..."
    @State private var isGenerating: Bool = false
    
    // MARK: - Data
    
    private let recommendedOutfit: RecommendedOutfit?
    private let dummyOutfit = OutfitDetailModel.dummy
    
    // MARK: - Init
    
    init(outfit: RecommendedOutfit? = nil) {
        self.recommendedOutfit = outfit
    }
    
    // MARK: - Layout
    
    private let imageHeight: CGFloat = 560
    
    // MARK: - Computed Data
    
    private var outfitTitle: String {
        recommendedOutfit?.name ?? dummyOutfit.title
    }
    
    private var outfitColors: [Color] {
        if let recommendedOutfit {
            let colors = recommendedOutfit.items.compactMap {
                Color(hexString: $0.hex)
            }
            
            return colors.isEmpty ? dummyOutfit.colors : colors
        } else {
            return dummyOutfit.colors
        }
    }
    
    private var outfitKeywords: [OutfitKeywordModel] {
        if let recommendedOutfit {
            return recommendedOutfit.items.map { item in
                OutfitKeywordModel(
                    icon: iconName(for: item.key),
                    title: titleName(for: item.key),
                    description: "\(item.name), \(item.color)"
                )
            }
        } else {
            return dummyOutfit.keywords
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        // MARK: - Outfit Image
                        
                        outfitImageView
                            .frame(
                                width: proxy.size.width,
                                height: imageHeight + proxy.safeAreaInsets.top
                            )
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                        
                        // MARK: - Bottom Content
                        
                        VStack(alignment: .leading, spacing: 32) {
                            
                            // MARK: - Outfit Header
                            
                            OutfitHeaderView(
                                title: outfitTitle,
                                colors: outfitColors
                            )
                            
                            // MARK: - Style Keywords Section
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Style Keywords")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                ForEach(outfitKeywords) { item in
                                    OutfitKeywordRow(
                                        icon: item.icon,
                                        title: item.title,
                                        description: item.description
                                    )
                                }
                            }
                            
                            // MARK: - Why It Works Section
                            
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Why It Works")
                                        .font(.system(size: 18, weight: .semibold))
                                    
                                    if isGenerating {
                                        ProgressView()
                                            .controlSize(.small)
                                            .padding(.leading, 4)
                                    }
                                }
                                
                                Text(whyItWorksText)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.gray)
                                    .lineSpacing(6)
                                    .animation(.easeInOut, value: whyItWorksText)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 36)
                        .padding(.bottom, 48)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 40)
                        )
                        .offset(y: -32)
                        .padding(.bottom, -32)
                    }
                }
                .ignoresSafeArea(edges: .top)
                
                // MARK: - Top Navigation
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.black)
                                .frame(width: 44, height: 44)
                                .glassEffect()
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
                .safeAreaPadding(.top, 8)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .enableSwipeBackGesture()
        .task {
            await generateWhyItWorks()
        }
    }
    
    // MARK: - Image View
    
    @ViewBuilder
    private var outfitImageView: some View {
        if let recommendedOutfit,
           let url = URL(string: recommendedOutfit.imageURL) {
            
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.12))
                        .overlay {
                            ProgressView()
                        }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .top
                        )
                    
                case .failure:
                    Image(dummyOutfit.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .top
                        )
                    
                @unknown default:
                    Image(dummyOutfit.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .top
                        )
                }
            }
            .id(recommendedOutfit.imageURL)
            
        } else {
            Image(dummyOutfit.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
        }
    }
    
    // MARK: - Helpers
    
    private func iconName(for key: String) -> String {
        let normalizedKey = key.lowercased()
        
        if normalizedKey.contains("top") ||
            normalizedKey.contains("shirt") ||
            normalizedKey.contains("tshirt") {
            return "tshirt"
        }
        
        if normalizedKey.contains("bottom") ||
            normalizedKey.contains("pants") ||
            normalizedKey.contains("trouser") {
            return "figure.walk"
        }
        
        if normalizedKey.contains("outer") ||
            normalizedKey.contains("jacket") ||
            normalizedKey.contains("coat") {
            return "tshirt"
        }
        
        if normalizedKey.contains("shoe") ||
            normalizedKey.contains("sneaker") ||
            normalizedKey.contains("loafer") {
            return "shoeprints.fill"
        }
        
        return "tag"
    }
    
    private func titleName(for key: String) -> String {
        let normalizedKey = key.lowercased()
        
        if normalizedKey.contains("top") ||
            normalizedKey.contains("shirt") ||
            normalizedKey.contains("tshirt") {
            return "Tops"
        }
        
        if normalizedKey.contains("bottom") ||
            normalizedKey.contains("pants") ||
            normalizedKey.contains("trouser") {
            return "Bottoms"
        }
        
        if normalizedKey.contains("outer") ||
            normalizedKey.contains("jacket") ||
            normalizedKey.contains("coat") {
            return "Outer"
        }
        
        if normalizedKey.contains("shoe") ||
            normalizedKey.contains("sneaker") ||
            normalizedKey.contains("loafer") {
            return "Shoes"
        }
        
        return key
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
    }
    
    // MARK: - AI Generation
    
    private func generateWhyItWorks() async {
        guard let outfit = recommendedOutfit else {
            whyItWorksText = "This look uses a subtle analogous color harmony between the blue tones in the navy jeans and steel blue sneakers, creating a naturally connected palette. The white tee brightens the outfit for balance, while the black bomber jacket adds depth and sharp contrast that makes the silhouette feel cleaner and more refined."
            return
        }
        
        isGenerating = true
        defer { isGenerating = false }
        
        #if canImport(FoundationModels)
        if #available(iOS 18.0, *) {
            do {
                let model = SystemLanguageModel.default
                
                let instructions = """
                You are a fashion styling assistant for a mobile outfit recommendation app.
                Generate a short UX writing paragraph explaining why an outfit works visually and stylistically.
                
                Rules:
                - Mention every clothing item naturally.
                - Identify the outfit's color harmony type when relevant (analogous, complementary, monochromatic, triadic, neutral harmony, etc.).
                - Explain briefly why the harmony works visually.
                - Briefly mention contrast, balance, silhouette, or texture.
                - Keep the tone modern, concise, and easy to read on mobile.
                - Maximum 100 words.
                - Avoid overly technical fashion language.
                - Output only the paragraph.
                """
                
                let session = LanguageModelSession(
                    model: model,
                    instructions: instructions
                )
                
                let itemsList = outfit.items.map {
                    "\($0.name) (\($0.color))"
                }
                .joined(separator: "\n")
                
                let prompt = "Outfit Data:\n\(itemsList)"
                
                let response = try await session.respond(to: prompt)
                
                await MainActor.run {
                    self.whyItWorksText = response.content
                }
                
            } catch {
                print("AI Generation Error: \(error)")
                whyItWorksText = "This outfit presents a well-balanced color harmony with solid contrast and a modern silhouette."
            }
            
            return
        }
        #endif
        
        whyItWorksText = "This outfit presents a well-balanced color harmony with solid contrast and a modern silhouette. (Generated on unsupported OS version)"
    }
}

// MARK: - Hex Color Helper

private extension Color {
    init?(hexString: String) {
        var cleanedHex = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }
        
        guard cleanedHex.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self = Color(red: red, green: green, blue: blue)
    }
}

// MARK: - Swipe Back Gesture Enabler

private struct SwipeBackGestureEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
                navigationController.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {
        DispatchQueue.main.async {
            if let navigationController = uiViewController.navigationController {
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
                navigationController.interactivePopGestureRecognizer?.delegate = nil
            }
        }
    }
}

private extension View {
    func enableSwipeBackGesture() -> some View {
        self.background(
            SwipeBackGestureEnabler()
                .frame(width: 0, height: 0)
        )
    }
}

#Preview {
    OutfitDetailView()
}
