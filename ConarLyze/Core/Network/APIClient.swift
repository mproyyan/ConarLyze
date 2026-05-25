//
//  APIClient.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    // MARK: - JSON Request
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Data? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        guard let url = URL(string: APIConfig.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return try await perform(request)
    }
    
    // MARK: - Multipart Upload Request
    
    func uploadMultipart<T: Decodable>(
        endpoint: String,
        imageData: Data,
        fieldName: String = "image",
        fileName: String = "photo.jpg",
        mimeType: String = "image/jpeg",
        additionalFields: [String: String] = [:]
    ) async throws -> T {
        guard let url = URL(string: APIConfig.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )
        
        let body = createMultipartBody(
            imageData: imageData,
            fieldName: fieldName,
            fileName: fileName,
            mimeType: mimeType,
            additionalFields: additionalFields,
            boundary: boundary
        )
        
        request.httpBody = body
        
        return try await perform(request)
    }
    
    // MARK: - Private Request Performer
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            print("Request URL:", request.url?.absoluteString ?? "No URL")
            print("Request Method:", request.httpMethod ?? "No Method")
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            print("URL:", request.url?.absoluteString ?? "No URL")
            print("Status code:", httpResponse.statusCode)
            print("Raw response:", String(data: data, encoding: .utf8) ?? "No response")
            
            guard 200...299 ~= httpResponse.statusCode else {
                let message = String(data: data, encoding: .utf8)
                throw NetworkError.requestFailed(
                    statusCode: httpResponse.statusCode,
                    message: message
                )
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Decoding error:", error)
                print("Raw response:", String(data: data, encoding: .utf8) ?? "No response")
                throw NetworkError.decodingFailed
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
    // MARK: - Multipart Body Builder
    
    private func createMultipartBody(
        imageData: Data,
        fieldName: String,
        fileName: String,
        mimeType: String,
        additionalFields: [String: String],
        boundary: String
    ) -> Data {
        var body = Data()
        
        for (key, value) in additionalFields {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
}

// MARK: - Data Helper

private extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
