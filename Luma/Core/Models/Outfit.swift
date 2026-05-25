//
//  Outfit.swift
//  Luma
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

struct RecommendedOutfit: Identifiable, Codable {
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
    let items: [RecommendedOutfitItem]
    let score: Double?
    let reasons: [String]
    let rank: Int?
}

struct RecommendedOutfitItem: Identifiable, Codable {
    var id: String {
        key
    }
    
    let key: String
    let name: String
    let color: String
    let hex: String
}
