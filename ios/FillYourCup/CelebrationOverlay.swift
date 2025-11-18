import SwiftUI

struct CelebrationOverlay: View {
    @State private var animate: Bool = false

    struct Particle: Identifiable {
        let id = UUID()
        let startX: CGFloat
        let endX: CGFloat
        let endY: CGFloat
        let scale: CGFloat
        let delay: Double
    }

    private let particles: [Particle] = (0..<16).map { _ in
        Particle(
            startX: CGFloat.random(in: -40...40),
            endX: CGFloat.random(in: -90...90),
            endY: CGFloat.random(in: -220 ... -140),
            scale: CGFloat.random(in: 0.6...1.2),
            delay: Double.random(in: 0...0.2)
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear

                ZStack {
                    ForEach(particles) { particle in
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.purple.opacity(0.9))
                            .scaleEffect(particle.scale)
                            .offset(
                                x: animate ? particle.endX : particle.startX,
                                y: animate ? particle.endY : 0
                            )
                            .opacity(animate ? 0 : 1)
                            .animation(
                                .easeOut(duration: 1.0)
                                    .delay(particle.delay),
                                value: animate
                            )
                    }
                }
                .frame(width: 200, height: 260)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.33)
            }
            .onAppear {
                animate = true
            }
        }
        .ignoresSafeArea()
    }
}
