//
//  WeatherModel.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

struct WeatherResponse: Codable {
  let current: CurrentWeather
}

struct CurrentWeather: Codable {
  let temp_c: Double
  let humidity: Int
  let uv: Double
}
