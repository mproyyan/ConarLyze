//
//  EditColorType.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

//
//  ColorParameterExplanation.swift
//  Luma
//
//  Created by Ria Angela Tanujaya on 21/05/26.
//

import SwiftUI

struct ColorParameterExplanation: View {
    // 1. Ganti teks statis dengan properti model data dinamis
    let info: DetailInformation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // MARK: - General Explanation
            VStack(alignment: .leading, spacing: 16) {
                Text(info.title) // Menampilkan "What is Undertone?", dll.
                    .font(.title2.bold())
                    .padding(.top, 20)
                
                Text(info.value) // Menampilkan penjelasan umum dari parameter
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            // MARK: - User Personal Result
            VStack(alignment: .leading, spacing: 16) {
                Text(info.questionResult) // Menampilkan "How about your undertone?", dll.
                    .font(.title2.bold())
                    .padding(.top, 20)
                
                Text(info.answerResult) // Menampilkan hasil analisis asli milik user
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        // 2. Judul di bar atas otomatis dipotong menyesuaikan parameternya (Contoh: "Undertone")
        .navigationTitle(cleanNavigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 16)
    }
    
    // Helper untuk membersihkan "What is Undertone?" menjadi "Undertone" saja di Navigation Bar
    private var cleanNavigationTitle: String {
        info.title
            .replacingOccurrences(of: "What is ", with: "")
            .replacingOccurrences(of: "?", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    // Berikan mock data dummy di dalam Preview agar Xcode tidak error saat merender canvas
    NavigationStack {
        ColorParameterExplanation(
            info: DetailInformation(
                title: "What is Undertone?",
                value: "Undertone is the natural color that exists beneath the surface of your skin.",
                questionResult: "How about your undertone?",
                answerResult: "Your skin has cool-leaning undertones suited to cool palettes."
            )
        )
    }
}
