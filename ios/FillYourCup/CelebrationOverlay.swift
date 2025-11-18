import SwiftUI

struct CelebrationOverlay: View {
    @State private var animate: Bool = false
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0

    struct Particle: Identifiable {
        let id = UUID()
        let startX: CGFloat
        let endX: CGFloat
        let endY: CGFloat
        let scale: CGFloat
        let delay: Double
        let color: Color
    }

    private let particles: [Particle] = (0..<24).map { index in
        let colors: [Color] = [.purple, .blue, .green, .pink]
        return Particle(
            startX: CGFloat.random(in: -40...40),
            endX: CGFloat.random(in: -120...120),
            endY: CGFloat.random(in: -280 ... -160),
            scale: CGFloat.random(in: 0.5...1.5),
            delay: Double.random(in: 0...0.3),
            color: colors[index % colors.count]
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background blur
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .blur(radius: 2)
                
                ZStack {
                    // Central star
                    Image(systemName: "star.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.purple, .pink, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .shadow(color: .purple.opacity(0.8), radius: 20)
                    
                    // Particles
                    ForEach(particles) { particle in
                        Image(systemName: ["star.fill", "sparkle", "star"].randomElement() ?? "star.fill")
                            .foregroundColor(particle.color)
                            .font(.system(size: 20))
                            .scaleEffect(particle.scale)
                            .offset(
                                x: animate ? particle.endX : particle.startX,
                                y: animate ? particle.endY : 0
                            )
                            .opacity(animate ? 0 : 1)
                            .rotationEffect(.degrees(animate ? Double.random(in: 0...360) : 0))
                            .animation(
                                .spring(response: 0.8, dampingFraction: 0.5)
                                    .delay(particle.delay),
                                value: animate
                            )
                    }
                }
                .frame(width: 300, height: 300)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.33)
            }
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    scale = 1.2
                    rotation = 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animate = true
                }
            }
        }
        .ignoresSafeArea()
    }
}
