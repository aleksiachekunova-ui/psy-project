import SwiftUI

// MARK: - Animated Button Style
// PURPOSE: Стиль кнопки с spring анимацией и haptic feedback
// CONTRACT: Применяется к Button, добавляет scale эффект при нажатии

struct AnimatedButtonStyle: ButtonStyle {
    let color: Color?
    let scale: CGFloat
    
    init(color: Color? = nil, scale: CGFloat = 0.95) {
        self.color = color
        self.scale = scale
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed {
                    HapticFeedback.light()
                }
            }
    }
}

// MARK: - Scale Button Style
// PURPOSE: Простой стиль с масштабированием
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

