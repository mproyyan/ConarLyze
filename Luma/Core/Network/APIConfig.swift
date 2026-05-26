//
//  APIConfig.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

enum APIConfig {
    static let baseURL = "http://172.208.49.14:3000"
    
    static let health = "/health"
    static let analyzeColor = "/api/v1/analyze-color"
    static let pickColor = "/api/v1/pick-color"
    static let recommendOutfit = "/api/v1/recommend"
}
