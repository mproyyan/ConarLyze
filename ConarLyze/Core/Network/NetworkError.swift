//
//  NetworkError.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int, message: String?)
    case decodingFailed
    case noData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL tidak valid."
        case .invalidResponse:
            return "Response dari server tidak valid."
        case .requestFailed(let statusCode, let message):
            return "Request gagal dengan status code \(statusCode). \(message ?? "")"
        case .decodingFailed:
            return "Gagal membaca data dari server."
        case .noData:
            return "Server tidak mengirim data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
