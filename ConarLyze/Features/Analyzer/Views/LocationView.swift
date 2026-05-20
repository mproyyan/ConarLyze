//
//  LocationView.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI
struct LocationView: View {
  
  @StateObject private var viewModel = LocationViewModel()
  
  var body: some View {
    VStack(spacing: 30) {
      
      VStack(spacing: 20) {
        Text("I live in...")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        Text("We'll customize your recommendations for your local climate and lifestyle")
          .font(.system(size: 20))
          .multilineTextAlignment(.center)
      }
      
      Button {
        viewModel.requestLocation()
      } label: {
        HStack {
          Image(systemName: "location.fill")
          
          Text(
            viewModel.locationText.isEmpty
            ? "Tap to detect your location"
            : viewModel.locationText
          )
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
      }
      
      HStack(spacing: 10) {
        ClimateCard(
          title: "Temperature",
          icon: "thermometer.variable",
          value: viewModel.temperature
        )
        
        ClimateCard(
          title: "Humidity",
          icon: "humidity",
          value: viewModel.humidity
        )
        
        ClimateCard(
          title: "UV Index",
          icon: "sun.max",
          value: viewModel.uvIndex
        )
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .onAppear {
      viewModel.observeLocation()
    }
  }
}
#Preview {
    LocationView()
}
