//
//  OutfitDTO.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct OutfitDTO: Codable, Identifiable {
    let id: String
    let name: String
    let imageURL: String
    let gender: String
    let styleTag: String
    let harmonyTag: String
    let undertone: String
    let contrastLevel: String
    let environments: [String]
    let weatherSupport: [String]
    let items: OutfitItemsDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case gender
        case styleTag = "style_tag"
        case harmonyTag = "harmony_tag"
        case undertone
        case contrastLevel = "contrast_level"
        case environments
        case weatherSupport = "weather_support"
        case items
    }
}

struct OutfitItemsDTO: Codable {
    let top: OutfitItemDTO?
    let bottom: OutfitItemDTO?
    let outer: OutfitItemDTO?
    let shoes: OutfitItemDTO?
}

struct OutfitItemDTO: Codable {
    let name: String
    let color: String
    let hex: String
}
