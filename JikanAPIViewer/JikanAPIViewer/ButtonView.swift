import SwiftUI

struct ButtonView: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(3)
            .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]), startPoint: .leading, endPoint: .trailing))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
