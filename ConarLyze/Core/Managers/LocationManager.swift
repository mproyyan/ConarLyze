//
//  LocationManager.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import Foundation
import CoreLocation
internal import Combine

final class LocationManager: NSObject, ObservableObject {
  private let manager = CLLocationManager()
  
  @Published var location: CLLocation?
  @Published var city: String = ""
  @Published var province: String = ""
  @Published var country: String = ""
  
  override init() {
    super.init()
    
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func requestLocation() {
    manager.requestWhenInUseAuthorization()
    manager.requestLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    
    self.location = location
    
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      guard let place = placemarks?.first else { return }
      
      DispatchQueue.main.async {
        self.city = place.locality ?? ""
        self.province = place.administrativeArea ?? ""
        self.country = place.country ?? ""
      }
    }
  }
  
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error.localizedDescription)
  }
}
