//
//  LumaApp.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI

@main
struct LumaApp: App {
    @StateObject private var container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container)
        }
    }
}
