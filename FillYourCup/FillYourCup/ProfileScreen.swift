import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var appear = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(x: appear ? 0 : -20)

                    // Profile card
                    profileCard
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(y: appear ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1), value: appear)

                    // Statistics
                    statsSection
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(y: appear ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: appear)

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
    
    private var profileCard: some View {
        HStack(spacing: 20) {
            ZStack {
                if let avatarImageName = appState.avatarImageName {
                    AsyncImage(url: URL(string: avatarImageName)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.purple.opacity(0.3),
                                        Color.blue.opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                Text(appState.avatarInitials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                            )
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    )
                } else {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.purple.opacity(0.3),
                                    Color.blue.opacity(0.2)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text(appState.avatarInitials)
                                .font(.title)
                                .fontWeight(.semibold)
                        )
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                }
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 16, height: 16)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .offset(x: 28, y: 28)
            }
            .scaleEffect(appear ? 1.0 : 0.5)
            .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.15), value: appear)

            VStack(alignment: .leading, spacing: 6) {
                Text(appState.displayName)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Wellness Enthusiast")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(24)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Stats")
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 16) {
                statItem(
                    value: "\(appState.totalCount)",
                    label: "Total Tasks",
                    icon: "list.bullet",
                    color: .purple
                )
                statItem(
                    value: "\(appState.completedCount)",
                    label: "Completed",
                    icon: "checkmark.circle.fill",
                    color: .green
                )
                statItem(
                    value: "\(Int(appState.progress * 100))%",
                    label: "Progress",
                    icon: "chart.line.uptrend.xyaxis",
                    color: .blue
                )
            }
        }
        .padding(20)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
    }
    
    private func statItem(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.1))
        )
    }
}
