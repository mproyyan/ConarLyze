import SwiftUI

struct AnalysisInfoModel2: Identifiable {

    let id = UUID()
    let title: String
    let value: String
}

struct ColorSwatchModel2: Identifiable {

    let id = UUID()
    let title: String
    let hex: String
    let color: Color
}
struct DetailInformation: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let questionResult : String
    let answerResult : String
}

struct ColorAnalysisModel2 {

    let seasonTitle: String
    let infos: [AnalysisInfoModel2]
    let bestColors: [ColorSwatchModel2]
    let avoidColors: [ColorSwatchModel2]
    let parameterExplanation: [DetailInformation]

}

// MARK: - Dummy Data

extension ColorAnalysisModel2 {

    static let allSeasons: [ColorAnalysisModel2] = [

        ColorAnalysisModel2(

            seasonTitle: "Soft Summer",

            infos: [
                AnalysisInfoModel2(
                    title: "Undertone",
                    value: "Cool to Neutral Cool"
                )
            ],

            bestColors: [
                ColorSwatchModel2(
                    title: "Dusty Blue",
                    hex: "#7D9AAE",
                    color: Color(hex: 0x7D9AAE)
                )
            ],

            avoidColors: [
                ColorSwatchModel2(
                    title: "Bright Red",
                    hex: "#FF1E1E",
                    color: Color(hex: 0xFF1E1E)
                )
            ],
            parameterExplanation: [
                DetailInformation(
                    title: "What is undertone?",
                    value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.",
                    questionResult: "How about your undertone?",
                    answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes."
                )
            ]
        ),
        
        ColorAnalysisModel2(

            seasonTitle: "Light Summer",

            infos: [
                AnalysisInfoModel2(
                    title: "Undertone",
                    value: "Cool to Neutral Cool"
                )
            ],

            bestColors: [
                ColorSwatchModel2(
                    title: "Dusty Blue",
                    hex: "#7D9AAE",
                    color: Color(hex: 0x7D9AAE)
                )
            ],

            avoidColors: [
                ColorSwatchModel2(
                    title: "Bright Red",
                    hex: "#FF1E1E",
                    color: Color(hex: 0xFF1E1E)
                )
            ],
            parameterExplanation: [
                DetailInformation(
                    title: "What is undertone?",
                    value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.",
                    questionResult: "How about your undertone?",
                    answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes."
                )
            ]
         ),
        ColorAnalysisModel2(

            seasonTitle: "True Summer",

            infos: [
                AnalysisInfoModel2(
                    title: "Undertone",
                    value: "Cool to Neutral Cool"
                )
            ],

            bestColors: [
                ColorSwatchModel2(
                    title: "Dusty Blue",
                    hex: "#7D9AAE",
                    color: Color(hex: 0x7D9AAE)
                )
            ],

            avoidColors: [
                ColorSwatchModel2(
                    title: "Bright Red",
                    hex: "#FF1E1E",
                    color: Color(hex: 0xFF1E1E)
                )
            ],
            
            parameterExplanation: [
                DetailInformation(
                    title: "What is undertone?",
                    value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.",
                    questionResult: "How about your undertone?",
                    answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes."
                )
            ]
        )
    ]
}
