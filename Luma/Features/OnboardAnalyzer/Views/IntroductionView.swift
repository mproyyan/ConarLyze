//
//  IntroductionView.swift
//  Luma
//
//  Created by Muhammad Pandu Royyan on 19/05/26.
//

import SwiftUI

struct IntroductionView: View {
    @Binding var name: String
    @Binding var selectedGender: Gender?
    @State private var showValidationAlert = false
    let onNext: () -> Void
    enum Gender: String {
        case male
        case female
    }
    var isFormValid: Bool {
        !name.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty
        && selectedGender != nil
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Introduce Yourself")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Fill out the rest of your details so app can analyze your skin")
                    .font(.system(size: 20))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
            .padding(.bottom, 40)
            
            VStack(alignment: .leading) {
                // MARK: - Form
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Name")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        TextField("Name", text: $name)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(12)
                    }
                    
                    
                    // Gender
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Gender")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 16) {
                            
                            GenderCard(
                                title: "Male",
                                icon: "person.fill",
                                isSelected: selectedGender == .male
                            ) {
                                selectedGender = .male
                            }
                            
                            GenderCard(
                                title: "Female",
                                icon: "person.fill",
                                isSelected: selectedGender == .female
                            ) {
                                selectedGender = .female
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    if isFormValid {
                        onNext()
                    } else {
                        showValidationAlert = true
                    }
                }) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(30)
                    
                    
                }
            }
        }
        .padding(.horizontal, 20)
        .alert("Form Incomplete", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please fill in your name and select your gender before continuing.")
        }
    }
}

#Preview {
    IntroductionView(
        name: .constant(""),
        selectedGender: .constant(nil),
        onNext: {}
    )
}

