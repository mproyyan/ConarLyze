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
            seasonTitle: "Clear Spring",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#E8472A", color: Color(hex: 0xE8472A)),
                ColorSwatchModel2(title: "Color", hex: "#F4763A", color: Color(hex: 0xF4763A)),
                ColorSwatchModel2(title: "Color", hex: "#E8B020", color: Color(hex: 0xE8B020)),
                ColorSwatchModel2(title: "Color", hex: "#E8C84A", color: Color(hex: 0xE8C84A)),
                ColorSwatchModel2(title: "Color", hex: "#5BAD6A", color: Color(hex: 0x5BAD6A)),
                ColorSwatchModel2(title: "Color", hex: "#F28B6E", color: Color(hex: 0xF28B6E)),
                ColorSwatchModel2(title: "Color", hex: "#D94F7A", color: Color(hex: 0xD94F7A)),
                ColorSwatchModel2(title: "Color", hex: "#FFF0D6", color: Color(hex: 0xFFF0D6))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#8C8C78", color: Color(hex: 0x8C8C78)),
                ColorSwatchModel2(title: "Color", hex: "#6B7A8D", color: Color(hex: 0x6B7A8D)),
                ColorSwatchModel2(title: "Color", hex: "#7A6E88", color: Color(hex: 0x7A6E88)),
                ColorSwatchModel2(title: "Color", hex: "#5C6650", color: Color(hex: 0x5C6650)),
                ColorSwatchModel2(title: "Color", hex: "#A0896C", color: Color(hex: 0xA0896C)),
                ColorSwatchModel2(title: "Color", hex: "#3A3A3A", color: Color(hex: 0x3A3A3A)),
                ColorSwatchModel2(title: "Color", hex: "#7C8FA0", color: Color(hex: 0x7C8FA0)),
                ColorSwatchModel2(title: "Color", hex: "#9E8E7E", color: Color(hex: 0x9E8E7E))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Warm Spring",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#F5963C", color: Color(hex: 0xF5963C)),
                ColorSwatchModel2(title: "Color", hex: "#F2BE3A", color: Color(hex: 0xF2BE3A)),
                ColorSwatchModel2(title: "Color", hex: "#D4A800", color: Color(hex: 0xD4A800)),
                ColorSwatchModel2(title: "Color", hex: "#78B040", color: Color(hex: 0x78B040)),
                ColorSwatchModel2(title: "Color", hex: "#E07050", color: Color(hex: 0xE07050)),
                ColorSwatchModel2(title: "Color", hex: "#F0C080", color: Color(hex: 0xF0C080)),
                ColorSwatchModel2(title: "Color", hex: "#C86030", color: Color(hex: 0xC86030)),
                ColorSwatchModel2(title: "Color", hex: "#FDF0D0", color: Color(hex: 0xFDF0D0))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#4A506E", color: Color(hex: 0x4A506E)),
                ColorSwatchModel2(title: "Color", hex: "#7090A8", color: Color(hex: 0x7090A8)),
                ColorSwatchModel2(title: "Color", hex: "#9080A8", color: Color(hex: 0x9080A8)),
                ColorSwatchModel2(title: "Color", hex: "#606878", color: Color(hex: 0x606878)),
                ColorSwatchModel2(title: "Color", hex: "#8898A8", color: Color(hex: 0x8898A8)),
                ColorSwatchModel2(title: "Color", hex: "#B0A8C0", color: Color(hex: 0xB0A8C0)),
                ColorSwatchModel2(title: "Color", hex: "#3A3050", color: Color(hex: 0x3A3050)),
                ColorSwatchModel2(title: "Color", hex: "#505868", color: Color(hex: 0x505868))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Light Spring",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#F8D5A8", color: Color(hex: 0xF8D5A8)),
                ColorSwatchModel2(title: "Color", hex: "#FAE0B0", color: Color(hex: 0xFAE0B0)),
                ColorSwatchModel2(title: "Color", hex: "#F5E898", color: Color(hex: 0xF5E898)),
                ColorSwatchModel2(title: "Color", hex: "#C8E0A0", color: Color(hex: 0xC8E0A0)),
                ColorSwatchModel2(title: "Color", hex: "#F4B8A0", color: Color(hex: 0xF4B8A0)),
                ColorSwatchModel2(title: "Color", hex: "#E8C8B8", color: Color(hex: 0xE8C8B8)),
                ColorSwatchModel2(title: "Color", hex: "#F0D0B8", color: Color(hex: 0xF0D0B8)),
                ColorSwatchModel2(title: "Color", hex: "#FBF5E8", color: Color(hex: 0xFBF5E8))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#2A3050", color: Color(hex: 0x2A3050)),
                ColorSwatchModel2(title: "Color", hex: "#3A3850", color: Color(hex: 0x3A3850)),
                ColorSwatchModel2(title: "Color", hex: "#504868", color: Color(hex: 0x504868)),
                ColorSwatchModel2(title: "Color", hex: "#284040", color: Color(hex: 0x284040)),
                ColorSwatchModel2(title: "Color", hex: "#3C3028", color: Color(hex: 0x3C3028)),
                ColorSwatchModel2(title: "Color", hex: "#486050", color: Color(hex: 0x486050)),
                ColorSwatchModel2(title: "Color", hex: "#2C2840", color: Color(hex: 0x2C2840)),
                ColorSwatchModel2(title: "Color", hex: "#5A4030", color: Color(hex: 0x5A4030))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Light Summer",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#B8CCD8", color: Color(hex: 0xB8CCD8)),
                ColorSwatchModel2(title: "Color", hex: "#C0D0E0", color: Color(hex: 0xC0D0E0)),
                ColorSwatchModel2(title: "Color", hex: "#C8B8D0", color: Color(hex: 0xC8B8D0)),
                ColorSwatchModel2(title: "Color", hex: "#E0C8D0", color: Color(hex: 0xE0C8D0)),
                ColorSwatchModel2(title: "Color", hex: "#B8C8D0", color: Color(hex: 0xB8C8D0)),
                ColorSwatchModel2(title: "Color", hex: "#D0C8E0", color: Color(hex: 0xD0C8E0)),
                ColorSwatchModel2(title: "Color", hex: "#D8E4EC", color: Color(hex: 0xD8E4EC)),
                ColorSwatchModel2(title: "Color", hex: "#F4F0F8", color: Color(hex: 0xF4F0F8))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#D4622A", color: Color(hex: 0xD4622A)),
                ColorSwatchModel2(title: "Color", hex: "#C84820", color: Color(hex: 0xC84820)),
                ColorSwatchModel2(title: "Color", hex: "#B87800", color: Color(hex: 0xB87800)),
                ColorSwatchModel2(title: "Color", hex: "#8C4A18", color: Color(hex: 0x8C4A18)),
                ColorSwatchModel2(title: "Color", hex: "#A03820", color: Color(hex: 0xA03820)),
                ColorSwatchModel2(title: "Color", hex: "#784010", color: Color(hex: 0x784010)),
                ColorSwatchModel2(title: "Color", hex: "#C06030", color: Color(hex: 0xC06030)),
                ColorSwatchModel2(title: "Color", hex: "#905020", color: Color(hex: 0x905020))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Cool Summer",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#7A90A8", color: Color(hex: 0x7A90A8)),
                ColorSwatchModel2(title: "Color", hex: "#9098B8", color: Color(hex: 0x9098B8)),
                ColorSwatchModel2(title: "Color", hex: "#A888A0", color: Color(hex: 0xA888A0)),
                ColorSwatchModel2(title: "Color", hex: "#B89898", color: Color(hex: 0xB89898)),
                ColorSwatchModel2(title: "Color", hex: "#7A9890", color: Color(hex: 0x7A9890)),
                ColorSwatchModel2(title: "Color", hex: "#9090A8", color: Color(hex: 0x9090A8)),
                ColorSwatchModel2(title: "Color", hex: "#C0A8B8", color: Color(hex: 0xC0A8B8)),
                ColorSwatchModel2(title: "Color", hex: "#F0EEF4", color: Color(hex: 0xF0EEF4))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#C87830", color: Color(hex: 0xC87830)),
                ColorSwatchModel2(title: "Color", hex: "#D4A030", color: Color(hex: 0xD4A030)),
                ColorSwatchModel2(title: "Color", hex: "#C06828", color: Color(hex: 0xC06828)),
                ColorSwatchModel2(title: "Color", hex: "#A07848", color: Color(hex: 0xA07848)),
                ColorSwatchModel2(title: "Color", hex: "#B89060", color: Color(hex: 0xB89060)),
                ColorSwatchModel2(title: "Color", hex: "#8A6040", color: Color(hex: 0x8A6040)),
                ColorSwatchModel2(title: "Color", hex: "#D49850", color: Color(hex: 0xD49850)),
                ColorSwatchModel2(title: "Color", hex: "#904820", color: Color(hex: 0x904820))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Soft Summer",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#A0A098", color: Color(hex: 0xA0A098)),
                ColorSwatchModel2(title: "Color", hex: "#9898A8", color: Color(hex: 0x9898A8)),
                ColorSwatchModel2(title: "Color", hex: "#8AA098", color: Color(hex: 0x8AA098)),
                ColorSwatchModel2(title: "Color", hex: "#A89098", color: Color(hex: 0xA89098)),
                ColorSwatchModel2(title: "Color", hex: "#B0A8B8", color: Color(hex: 0xB0A8B8)),
                ColorSwatchModel2(title: "Color", hex: "#C0B0B0", color: Color(hex: 0xC0B0B0)),
                ColorSwatchModel2(title: "Color", hex: "#B8C0C8", color: Color(hex: 0xB8C0C8)),
                ColorSwatchModel2(title: "Color", hex: "#E8E4E0", color: Color(hex: 0xE8E4E0))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#E83020", color: Color(hex: 0xE83020)),
                ColorSwatchModel2(title: "Color", hex: "#B87800", color: Color(hex: 0xB87800)),
                ColorSwatchModel2(title: "Color", hex: "#30C890", color: Color(hex: 0x30C890)),
                ColorSwatchModel2(title: "Color", hex: "#E83080", color: Color(hex: 0xE83080)),
                ColorSwatchModel2(title: "Color", hex: "#1060D0", color: Color(hex: 0x1060D0)),
                ColorSwatchModel2(title: "Color", hex: "#D03870", color: Color(hex: 0xD03870)),
                ColorSwatchModel2(title: "Color", hex: "#101010", color: Color(hex: 0x101010)),
                ColorSwatchModel2(title: "Color", hex: "#E86020", color: Color(hex: 0xE86020))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Soft Autumn",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#C4936A", color: Color(hex: 0xC4936A)),
                ColorSwatchModel2(title: "Color", hex: "#D8B898", color: Color(hex: 0xD8B898)),
                ColorSwatchModel2(title: "Color", hex: "#B8B090", color: Color(hex: 0xB8B090)),
                ColorSwatchModel2(title: "Color", hex: "#A8A880", color: Color(hex: 0xA8A880)),
                ColorSwatchModel2(title: "Color", hex: "#708060", color: Color(hex: 0x708060)),
                ColorSwatchModel2(title: "Color", hex: "#B89870", color: Color(hex: 0xB89870)),
                ColorSwatchModel2(title: "Color", hex: "#D0C898", color: Color(hex: 0xD0C898)),
                ColorSwatchModel2(title: "Color", hex: "#EEE8D8", color: Color(hex: 0xEEE8D8))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#3070C0", color: Color(hex: 0x3070C0)),
                ColorSwatchModel2(title: "Color", hex: "#5050C8", color: Color(hex: 0x5050C8)),
                ColorSwatchModel2(title: "Color", hex: "#8030B8", color: Color(hex: 0x8030B8)),
                ColorSwatchModel2(title: "Color", hex: "#C030A0", color: Color(hex: 0xC030A0)),
                ColorSwatchModel2(title: "Color", hex: "#F0F8FF", color: Color(hex: 0xF0F8FF)),
                ColorSwatchModel2(title: "Color", hex: "#B020A0", color: Color(hex: 0xB020A0)),
                ColorSwatchModel2(title: "Color", hex: "#2848A0", color: Color(hex: 0x2848A0)),
                ColorSwatchModel2(title: "Color", hex: "#20B0D8", color: Color(hex: 0x20B0D8))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Warm Autumn",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#B85C20", color: Color(hex: 0xB85C20)),
                ColorSwatchModel2(title: "Color", hex: "#C89050", color: Color(hex: 0xC89050)),
                ColorSwatchModel2(title: "Color", hex: "#A06830", color: Color(hex: 0xA06830)),
                ColorSwatchModel2(title: "Color", hex: "#688030", color: Color(hex: 0x688030)),
                ColorSwatchModel2(title: "Color", hex: "#304820", color: Color(hex: 0x304820)),
                ColorSwatchModel2(title: "Color", hex: "#986040", color: Color(hex: 0x986040)),
                ColorSwatchModel2(title: "Color", hex: "#D0A040", color: Color(hex: 0xD0A040)),
                ColorSwatchModel2(title: "Color", hex: "#F8EED0", color: Color(hex: 0xF8EED0))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#20A8D0", color: Color(hex: 0x20A8D0)),
                ColorSwatchModel2(title: "Color", hex: "#40B8E0", color: Color(hex: 0x40B8E0)),
                ColorSwatchModel2(title: "Color", hex: "#A020C0", color: Color(hex: 0xA020C0)),
                ColorSwatchModel2(title: "Color", hex: "#8040E0", color: Color(hex: 0x8040E0)),
                ColorSwatchModel2(title: "Color", hex: "#C8F0F8", color: Color(hex: 0xC8F0F8)),
                ColorSwatchModel2(title: "Color", hex: "#E040B8", color: Color(hex: 0xE040B8)),
                ColorSwatchModel2(title: "Color", hex: "#3060D0", color: Color(hex: 0x3060D0)),
                ColorSwatchModel2(title: "Color", hex: "#C0A8D8", color: Color(hex: 0xC0A8D8))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Deep Autumn",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#5A2808", color: Color(hex: 0x5A2808)),
                ColorSwatchModel2(title: "Color", hex: "#7A4220", color: Color(hex: 0x7A4220)),
                ColorSwatchModel2(title: "Color", hex: "#8C5A28", color: Color(hex: 0x8C5A28)),
                ColorSwatchModel2(title: "Color", hex: "#9A7840", color: Color(hex: 0x9A7840)),
                ColorSwatchModel2(title: "Color", hex: "#506028", color: Color(hex: 0x506028)),
                ColorSwatchModel2(title: "Color", hex: "#384018", color: Color(hex: 0x384018)),
                ColorSwatchModel2(title: "Color", hex: "#B05C18", color: Color(hex: 0xB05C18)),
                ColorSwatchModel2(title: "Color", hex: "#D8C090", color: Color(hex: 0xD8C090))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#90E8F8", color: Color(hex: 0x90E8F8)),
                ColorSwatchModel2(title: "Color", hex: "#A0B8F8", color: Color(hex: 0xA0B8F8)),
                ColorSwatchModel2(title: "Color", hex: "#C0B0F8", color: Color(hex: 0xC0B0F8)),
                ColorSwatchModel2(title: "Color", hex: "#F8F4FF", color: Color(hex: 0xF8F4FF)),
                ColorSwatchModel2(title: "Color", hex: "#40D0F0", color: Color(hex: 0x40D0F0)),
                ColorSwatchModel2(title: "Color", hex: "#E0F8F8", color: Color(hex: 0xE0F8F8)),
                ColorSwatchModel2(title: "Color", hex: "#80B0F8", color: Color(hex: 0x80B0F8)),
                ColorSwatchModel2(title: "Color", hex: "#3080E8", color: Color(hex: 0x3080E8))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Clear Winter",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#902098", color: Color(hex: 0x902098)),
                ColorSwatchModel2(title: "Color", hex: "#7820D8", color: Color(hex: 0x7820D8)),
                ColorSwatchModel2(title: "Color", hex: "#1860E8", color: Color(hex: 0x1860E8)),
                ColorSwatchModel2(title: "Color", hex: "#00A8D8", color: Color(hex: 0x00A8D8)),
                ColorSwatchModel2(title: "Color", hex: "#00C8B0", color: Color(hex: 0x00C8B0)),
                ColorSwatchModel2(title: "Color", hex: "#B020A8", color: Color(hex: 0xB020A8)),
                ColorSwatchModel2(title: "Color", hex: "#F0F0F8", color: Color(hex: 0xF0F0F8)),
                ColorSwatchModel2(title: "Color", hex: "#181828", color: Color(hex: 0x181828))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#D8A870", color: Color(hex: 0xD8A870)),
                ColorSwatchModel2(title: "Color", hex: "#C88050", color: Color(hex: 0xC88050)),
                ColorSwatchModel2(title: "Color", hex: "#A07850", color: Color(hex: 0xA07850)),
                ColorSwatchModel2(title: "Color", hex: "#B89858", color: Color(hex: 0xB89858)),
                ColorSwatchModel2(title: "Color", hex: "#C8C090", color: Color(hex: 0xC8C090)),
                ColorSwatchModel2(title: "Color", hex: "#706040", color: Color(hex: 0x706040)),
                ColorSwatchModel2(title: "Color", hex: "#B86820", color: Color(hex: 0xB86820)),
                ColorSwatchModel2(title: "Color", hex: "#E8D8B8", color: Color(hex: 0xE8D8B8))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Cool Winter",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#101018", color: Color(hex: 0x101018)),
                ColorSwatchModel2(title: "Color", hex: "#F4F4F8", color: Color(hex: 0xF4F4F8)),
                ColorSwatchModel2(title: "Color", hex: "#182858", color: Color(hex: 0x182858)),
                ColorSwatchModel2(title: "Color", hex: "#601878", color: Color(hex: 0x601878)),
                ColorSwatchModel2(title: "Color", hex: "#680870", color: Color(hex: 0x680870)),
                ColorSwatchModel2(title: "Color", hex: "#183898", color: Color(hex: 0x183898)),
                ColorSwatchModel2(title: "Color", hex: "#284880", color: Color(hex: 0x284880)),
                ColorSwatchModel2(title: "Color", hex: "#500050", color: Color(hex: 0x500050))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#C8906A", color: Color(hex: 0xC8906A)),
                ColorSwatchModel2(title: "Color", hex: "#C8A850", color: Color(hex: 0xC8A850)),
                ColorSwatchModel2(title: "Color", hex: "#E8D8A0", color: Color(hex: 0xE8D8A0)),
                ColorSwatchModel2(title: "Color", hex: "#B06828", color: Color(hex: 0xB06828)),
                ColorSwatchModel2(title: "Color", hex: "#A07848", color: Color(hex: 0xA07848)),
                ColorSwatchModel2(title: "Color", hex: "#B09878", color: Color(hex: 0xB09878)),
                ColorSwatchModel2(title: "Color", hex: "#A09060", color: Color(hex: 0xA09060)),
                ColorSwatchModel2(title: "Color", hex: "#586030", color: Color(hex: 0x586030))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        ),
        ColorAnalysisModel2(
            seasonTitle: "Deep Winter",
            infos: [
                AnalysisInfoModel2(title: "Undertone", value: "Cool to Neutral Cool")
            ],
            bestColors: [
                ColorSwatchModel2(title: "Color", hex: "#101018", color: Color(hex: 0x101018)),
                ColorSwatchModel2(title: "Color", hex: "#181830", color: Color(hex: 0x181830)),
                ColorSwatchModel2(title: "Color", hex: "#182050", color: Color(hex: 0x182050)),
                ColorSwatchModel2(title: "Color", hex: "#380898", color: Color(hex: 0x380898)),
                ColorSwatchModel2(title: "Color", hex: "#680898", color: Color(hex: 0x680898)),
                ColorSwatchModel2(title: "Color", hex: "#500860", color: Color(hex: 0x500860)),
                ColorSwatchModel2(title: "Color", hex: "#480868", color: Color(hex: 0x480868)),
                ColorSwatchModel2(title: "Color", hex: "#E8EAF0", color: Color(hex: 0xE8EAF0))
            ],
            avoidColors: [
                ColorSwatchModel2(title: "Color", hex: "#F8D898", color: Color(hex: 0xF8D898)),
                ColorSwatchModel2(title: "Color", hex: "#F8E8A8", color: Color(hex: 0xF8E8A8)),
                ColorSwatchModel2(title: "Color", hex: "#F4F0C8", color: Color(hex: 0xF4F0C8)),
                ColorSwatchModel2(title: "Color", hex: "#C8F0B8", color: Color(hex: 0xC8F0B8)),
                ColorSwatchModel2(title: "Color", hex: "#F8E8D0", color: Color(hex: 0xF8E8D0)),
                ColorSwatchModel2(title: "Color", hex: "#D8B898", color: Color(hex: 0xD8B898)),
                ColorSwatchModel2(title: "Color", hex: "#C8C898", color: Color(hex: 0xC8C898)),
                ColorSwatchModel2(title: "Color", hex: "#E8D8B0", color: Color(hex: 0xE8D8B0))
            ],
            parameterExplanation: [
                DetailInformation(title: "What is undertone?", value: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.", questionResult: "How about your undertone?", answerResult: "Your skin has cool-leaning undertones with a hint of neutrality, suited to silver-based tones and cool palettes.")
            ]
        )
    ]
}
