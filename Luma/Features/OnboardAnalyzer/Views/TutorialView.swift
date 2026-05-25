    //
    //  TutorialView.swift
    //  Luma
    //
    //  Created by Muhammad Pandu Royyan on 20/05/26.
    //

    import SwiftUI

    struct TutorialView: View {
        let onNext: () -> Void
        var body: some View {
            VStack {
                VStack {
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
        TutorialView(onNext: {})
    }
