//
//  OutfitDetailView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 21/05/26.
//

import SwiftUI

struct OutfitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Dummy Data
    private let outfit = OutfitDetailModel.dummy
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // MARK: - Outfit Image
                    Image(outfit.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 500)
                    
                    // MARK: - Bottom Content
                    
                    VStack(alignment: .leading, spacing: 32) {
                    
                        // MARK: - Outfit Header
                        OutfitHeaderView(
                            title: outfit.title,
                            colors: outfit.colors
                        )
                        
                        // MARK: - Style Keywords Section
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text("Style Keywords")
                                .font(.title3.weight(.medium))
                            
                            // MARK: - Outfit Keyword Rows
                            
                            ForEach(outfit.keywords) { item in
                                
                                OutfitKeywordRow(
                                    icon: item.icon,
                                    title: item.title,
                                    description: item.description
                                )
                            }
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
            
            // MARK: - Top Navigation
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                            .glassEffect()
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
//                .padding(.top, 20)
                Spacer()
            }
            .safeAreaPadding(.top, 56)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OutfitDetailView()
}

