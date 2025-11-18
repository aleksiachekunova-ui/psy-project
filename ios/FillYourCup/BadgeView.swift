import SwiftUI

// MARK: - Badge View Component
// PURPOSE: Displays a badge card with icon, name, and subtitle
// CONTRACT: Takes a Badge model and displays it in a styled card

struct BadgeCardView: View {
    let badge: Badge
    @State private var appear = false
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(badge.color.circleColor)
                    .frame(width: 50, height: 50)
                Image(systemName: badge.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .scaleEffect(appear ? 1.0 : 0.5)
            .opacity(appear ? 1.0 : 0.0)
            
            VStack(spacing: 4) {
                Text(badge.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(badge.subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 110, height: 140)
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(badge.color.backgroundColor)
        )
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                appear = true
            }
        }
    }
}

struct BadgesSectionView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Badges")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                if !appState.badges.isEmpty {
                    Button("View all") {
                        // Navigate to all badges
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
            }
            
            if appState.recentBadges.isEmpty {
                Text("Complete tasks to earn badges!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(appState.recentBadges) { badge in
                            BadgeCardView(badge: badge)
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
        }
        .padding(20)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
    }
}

