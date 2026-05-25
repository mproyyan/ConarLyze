//
//  LocalStateRepository.swift
//  ConarLyze
//
//  Created by Daffa Burane Nugraha on 25/05/26.
//

import Foundation

// MARK: - User Profile Model

struct UserProfile: Codable {
    let name: String
    let gender: String
}

// MARK: - Local State Repository Protocol

protocol LocalStateRepositoryProtocol {
    var hasCompletedOnboarding: Bool { get set }
    
    // User Profile
    func saveUserProfile(_ profile: UserProfile)
    func loadUserProfile() -> UserProfile?
    func clearUserProfile()
    
    // Convenience User Data
    func saveUserName(_ name: String)
    func loadUserName() -> String?
    func saveSelectedGender(_ gender: String)
    func loadSelectedGender() -> String?
    
    // Analysis Result
    func saveAnalysisResult<T: Encodable>(_ result: T)
    func loadAnalysisResult<T: Decodable>(as type: T.Type) -> T?
    func clearAnalysisResult()
    
    // Clear
    func clearAll()
}

// MARK: - Local State Repository

final class LocalStateRepository: LocalStateRepositoryProtocol {
    
    // MARK: - Singleton
    
    static let shared = LocalStateRepository()
    
    // MARK: - Private Properties
    
    private let userDefaults: UserDefaults
    
    private enum Key {
        static let userProfile = "user_profile"
        static let analysisResult = "analysis_result"
        
        // Dipakai oleh LocalStateRepository
        static let hasCompletedOnboarding = "has_completed_onboarding"
        
        // Dipakai oleh @AppStorage di View
        static let appStorageHasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    // MARK: - Init
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - Onboarding State
    
    var hasCompletedOnboarding: Bool {
        get {
            userDefaults.bool(forKey: Key.hasCompletedOnboarding) ||
            userDefaults.bool(forKey: Key.appStorageHasCompletedOnboarding)
        }
        set {
            userDefaults.set(newValue, forKey: Key.hasCompletedOnboarding)
            userDefaults.set(newValue, forKey: Key.appStorageHasCompletedOnboarding)
        }
    }
    
    // MARK: - User Profile
    
    func saveUserProfile(_ profile: UserProfile) {
        do {
            let data = try JSONEncoder().encode(profile)
            userDefaults.set(data, forKey: Key.userProfile)
        } catch {
            print("Failed to save user profile:", error)
        }
    }
    
    func loadUserProfile() -> UserProfile? {
        guard let data = userDefaults.data(forKey: Key.userProfile) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(UserProfile.self, from: data)
        } catch {
            print("Failed to load user profile:", error)
            return nil
        }
    }
    
    func clearUserProfile() {
        userDefaults.removeObject(forKey: Key.userProfile)
    }
    
    // MARK: - Convenience User Data
    
    func saveUserName(_ name: String) {
        let currentGender = loadUserProfile()?.gender ?? ""
        let profile = UserProfile(
            name: name,
            gender: currentGender
        )
        
        saveUserProfile(profile)
    }
    
    func loadUserName() -> String? {
        loadUserProfile()?.name
    }
    
    func saveSelectedGender(_ gender: String) {
        let currentName = loadUserProfile()?.name ?? ""
        let profile = UserProfile(
            name: currentName,
            gender: gender
        )
        
        saveUserProfile(profile)
    }
    
    func loadSelectedGender() -> String? {
        loadUserProfile()?.gender
    }
    
    // MARK: - Analysis Result
    
    func saveAnalysisResult<T: Encodable>(_ result: T) {
        do {
            let data = try JSONEncoder().encode(result)
            userDefaults.set(data, forKey: Key.analysisResult)
        } catch {
            print("Failed to save analysis result:", error)
        }
    }
    
    func loadAnalysisResult<T: Decodable>(as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: Key.analysisResult) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Failed to load analysis result:", error)
            return nil
        }
    }
    
    func clearAnalysisResult() {
        userDefaults.removeObject(forKey: Key.analysisResult)
    }
    
    // MARK: - Clear All
    
    func clearAll() {
        clearUserProfile()
        clearAnalysisResult()
        hasCompletedOnboarding = false
    }
}
