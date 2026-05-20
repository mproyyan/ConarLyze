//
//  LocationViewModel.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import Foundation
import CoreLocation
internal import Combine

@MainActor
final class LocationViewModel: ObservableObject {
  
  @Published var locationText: String = ""
  
  @Published var temperature: String = "--"
  @Published var humidity: String = "--"
  @Published var uvIndex: String = "--"
  
  let locationManager = LocationManager()
  private let weatherService = WeatherService()
  
  func requestLocation() {
    locationManager.requestLocation()
  }
  
  func observeLocation() {
    Task {
      while true {
        try? await Task.sleep(for: .seconds(1))
        
        guard let location = locationManager.location else {
          continue
        }
        
        print(locationManager.location)
        
        locationText =
        "\(locationManager.province), \(locationManager.city), \(locationManager.country)"
        
        await fetchWeather(location: location)
        
        break
      }
    }
  }
  
  private func fetchWeather(location: CLLocation) async {
    do {
      let weather = try await weatherService.fetchWeather(
        latitude: location.coordinate.latitude,
        longitude: location.coordinate.longitude
      )
      
      temperature = "\(Int(weather.current.temp_c))°C"
      humidity = "\(weather.current.humidity)%"
      uvIndex = "\(weather.current.uv)"
      
    } catch {
      print(error.localizedDescription)
    }
  }
}
