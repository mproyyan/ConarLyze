//
//  WeatherService.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import Foundation

final class WeatherService {
  
  private let apiKey = ""
  
  func fetchWeather(
    latitude: Double,
    longitude: Double
  ) async throws -> WeatherResponse {
    
    let urlString =
    "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(latitude),\(longitude)"
    
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let response = try JSONDecoder().decode(
      WeatherResponse.self,
      from: data
    )
    
    return response
  }
}
