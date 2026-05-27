    //
    //  TutorialView.swift
    //  Luma
    //
    //  Created by Muhammad Pandu Royyan on 20/05/26.
    //

    import SwiftUI

    struct TutorialView: View {
        let onBack: () -> Void
        let onNext: () -> Void
        
        var body: some View {
            VStack {
                VStack {
                    HStack {
                        Button(action: onBack) {
                            Image(systemName: "chevron.left")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.black)
                                .frame(width: 52, height: 52)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(
                            "Let's get your color analysis \(Text("right").foregroundColor(.orange))"
                        )
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                        Text("Follow these simple steps to help us deliver the most accurate result")
                            .foregroundStyle(Color.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 24)
                    
                    VStack(spacing: 32) {
                        StepTutorial(icon: "camera.aperture", title: "Clean camera lens", description: "Wipe your camera to make sure your photo is clear and sharp.")
                        StepTutorial(icon: "eyeglasses.slash", title: "Remove glasses & accessories", description: "Take off your glasses and any hair accessories.")
                        StepTutorial(icon: "sun.max", title: "Use natural light", description: "Face a window and avoid direct sunlight or harsh shadows.")
                        StepTutorial(icon: "face.smiling", title: "Keep a neutral expression ", description: "Relax your face and look straight at the camera.")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        onNext()
                    }) {
                        ButtonView(text: "Next")
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }

    #Preview {
        TutorialView(onBack: {}, onNext: {})
    }
