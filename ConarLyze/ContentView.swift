//
//  ContentView.swift
//  ConarLyze
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI

struct ContentView: View {

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        if hasCompletedOnboarding {
            HomeView()
        } else {
            OnboardingFlowView()
        }

    }
}

#Preview {
    ContentView()
}
