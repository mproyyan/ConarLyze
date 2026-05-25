//
//  HomeView.swift
//  ConarLyze
//
//  Created by Ahmad Zaki on 22/05/26.
//

import SwiftUI

struct HomeView: View {
  
  private let ideas = FashionIdeaModel.dummy
  
  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        
        VStack(alignment: .leading, spacing: 28) {
          
          // MARK: - Header
          HomeHeaderView()
          NavigationLink {
            ColorAnalysisView()
          } label: {
            AnalyzeCard(cardType: .softSummer)
          }
          .buttonStyle(.plain)
          .frame(height: 330)
          
          // MARK: - Fashion Ideas Section
          VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
              HStack(spacing: 8) {
                Image(systemName: "tshirt")
                  .foregroundStyle(.secondary)
                
                Text("CURATED FOR YOU")
                  .font(.subheadline)
                  .foregroundStyle(.secondary)
              }
              Text("Fashion Ideas")
                .font(.title.bold())
            }
            VStack(spacing: 16) {
              ForEach(ideas) { item in
                NavigationLink {
                  OutfitDetailView()
                } label: {
                  FashionIdeaCard(item: item)
                }
                .buttonStyle(.plain)
              }
            }
          }
          // MARK: - Browse More
          BrowseMoreButton()
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 16)
      }
      .background(
        Color(.systemGroupedBackground)
      )
    }
  }
}

#Preview {
  HomeView()
}
