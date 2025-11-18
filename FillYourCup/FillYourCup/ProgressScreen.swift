import SwiftUI

struct ProgressScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var appear = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your Progress")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(x: appear ? 0 : -20)

                    HStack(spacing: 16) {
                        statCard(
                            title: "\(appState.completedCount)",
                            subtitle: "Tasks completed today",
                            systemImage: "checkmark.circle.fill",
                            color: .green,
                            delay: 0.1
                        )
                        statCard(
                            title: String(format: "%.0f%%", appState.progress * 100),
                            subtitle: "Cup filled today",
                            systemImage: "cup.and.saucer.fill",
                            color: .purple,
                            delay: 0.2
                        )
                    }

                    // Progress chart
                    progressChart
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(y: appear ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: appear)

                    Spacer()
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemGroupedBackground),
                        Color(.systemGroupedBackground).opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    appear = true
                }
            }
        }
    }

    private func statCard(title: String, subtitle: String, systemImage: String, color: Color, delay: Double) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: systemImage)
                    .font(.system(size: 24))
                    .foregroundColor(color)
            }
            .scaleEffect(appear ? 1.0 : 0.0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(delay), value: appear)

            Text(title)
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.primary)
                .opacity(appear ? 1.0 : 0.0)
                .offset(y: appear ? 0 : 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(delay + 0.1), value: appear)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .opacity(appear ? 1.0 : 0.0)
                .offset(y: appear ? 0 : 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(delay + 0.15), value: appear)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
    }
    
    private var progressChart: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Weekly Overview")
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(0..<7) { day in
                    let heights: [CGFloat] = [80, 100, 70, 90, 110, 85, 95]
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.purple.opacity(0.8),
                                        Color.blue.opacity(0.6)
                                    ]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .frame(width: 30, height: appear ? heights[day] : 0)
                            .animation(
                                .spring(response: 0.6, dampingFraction: 0.7)
                                    .delay(Double(day) * 0.1),
                                value: appear
                            )
                        
                        Text(["M", "T", "W", "T", "F", "S", "S"][day])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(20)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
    }
}
