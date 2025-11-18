import SwiftUI

struct CupCardView: View {
    let name: String
    let progress: Double
    let completed: Int
    let total: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.93, green: 0.95, blue: 1.0),
                            Color(red: 0.96, green: 0.93, blue: 1.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            VStack(spacing: 18) {
                CupView(progress: progress)
                    .frame(height: 180)

                Text("\(Int(progress * 100))% Full")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.85))

                Text("\(completed) of \(total) tasks completed today")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 8) {
                    ForEach(0..<total, id: \.self) { index in
                        Circle()
                            .fill(index < completed ? Color.purple : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .padding(24)
        }
    }
}

struct CupView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height * 0.7)
            let height = width * 1.5
            let fillHeight = height * CGFloat(max(0.0, min(progress, 1.0)))

            ZStack {
                // Outer shadow
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color.white.opacity(0.0))
                    .frame(width: width + 12, height: height + 18)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 8)

                // Cup body
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .frame(width: width, height: height)

                    // Liquid
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.purple,
                                    Color.blue
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .frame(width: width - 18, height: fillHeight - 18)
                        .padding(.bottom, 9)
                        .mask(
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: width - 18, height: height - 18)
                                .padding(.bottom, 9)
                        )

                    // Inner white to keep top light
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white,
                                        Color.white.opacity(0.6)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: width - 18, height: height * 0.35)
                        Spacer()
                    }
                    .padding(.top, 9)
                }

                // Handle
                RoundedRectangle(cornerRadius: 26)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 5)
                    .frame(width: width * 0.38, height: height * 0.55)
                    .offset(x: width * 0.65)

                // Lid
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: width * 0.7, height: height * 0.18)
                    .offset(y: -height * 0.85)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
