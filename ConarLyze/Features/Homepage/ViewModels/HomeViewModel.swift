//
//  HomeViewModel.swift
//  ConarLyze
//

import Foundation
internal import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published var userName: String = "User"
    @Published var userProfile: UserProfile?
    @Published var analysisResult: ColorAnalysisResult?
    @Published var userPhoto: Data?
    @Published var ideas: [FashionIdeaModel] = FashionIdeaModel.dummy
    
    @Published var recommendedOutfits: [RecommendedOutfit] = []
    @Published var isLoadingOutfits: Bool = false
    @Published var outfitErrorMessage: String?
    @Published var totalLooks: Int?
    
    // MARK: - Dependencies
    
    private let localStateRepository: LocalStateRepositoryProtocol
    private let outfitRepository: OutfitRepositoryProtocol
    
    // MARK: - Init
    
    init(
        localStateRepository: LocalStateRepositoryProtocol = LocalStateRepository.shared,
        outfitRepository: OutfitRepositoryProtocol = OutfitRepository()
    ) {
        self.localStateRepository = localStateRepository
        self.outfitRepository = outfitRepository
        
        self.totalLooks = UserDefaults.standard.object(forKey: "cached_total_looks") as? Int
        
        loadLocalData()
    }
    
    // MARK: - Computed Properties
    
    var userGender: String {
        let gender = userProfile?.gender
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() ?? ""
        
        switch gender {
        case "female", "woman", "perempuan":
            return "female"
            
        case "male", "man", "laki-laki", "laki laki":
            return "male"
            
        default:
            return "male"
        }
    }
    
    var hasAnalysisResult: Bool {
        analysisResult != nil
    }
    
    
    // MARK: - Load Local Data
    
    func loadLocalData() {
        let profile = localStateRepository.loadUserProfile()
        let result = localStateRepository.loadAnalysisResult(
            as: ColorAnalysisResult.self
        )
        
        self.userProfile = profile
        self.analysisResult = result
        self.userPhoto = localStateRepository.loadUserPhoto()
        
        if let name = profile?.name.trimmingCharacters(in: .whitespacesAndNewlines),
           !name.isEmpty {
            self.userName = name
        } else {
            self.userName = "User"
        }
    }
    
    // MARK: - Load Backend Outfit Count
    
    func loadOutfitRecommendationsIfNeeded() async {
        guard recommendedOutfits.isEmpty else {
            return
        }
        
        guard let analysisResult else {
            return
        }
        
        isLoadingOutfits = true
        outfitErrorMessage = nil
        
        do {
            let outfits = try await outfitRepository.getRecommendations(
                bestColors: analysisResult.bestColors,
                avoidColors: analysisResult.avoidColors,
                gender: userGender
            )
            
            self.recommendedOutfits = outfits
            self.totalLooks = outfits.count
            
            UserDefaults.standard.set(outfits.count, forKey: "cached_total_looks")
            
            self.isLoadingOutfits = false
            
        } catch {
            print("Failed to load outfit count on Home:", error)
            self.outfitErrorMessage = error.localizedDescription
            self.isLoadingOutfits = false
        }
    }
}
