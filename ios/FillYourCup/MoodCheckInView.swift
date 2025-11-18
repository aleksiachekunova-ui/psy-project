import SwiftUI

// MARK: - Mood Check-In View
// PURPOSE: Allows users to quickly select their current mood
// CONTRACT: Displays mood options and updates AppState when selected

struct MoodCheckInView: View {
    @EnvironmentObject var appState: AppState
    @State private var appear = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("How are you feeling?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Quick mood check-in")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    // Show mood history
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 36, height: 36)
                        Image(systemName: "face.smiling")
                            .foregroundColor(.blue)
                            .font(.system(size: 18))
                    }
                }
            }
            
            HStack(spacing: 12) {
                ForEach(Mood.allCases) { mood in
                    moodButton(mood: mood)
                }
            }
        }
        .padding(20)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appear = true
            }
        }
    }
    
    private func moodButton(mood: Mood) -> some View {
        Button(action: {
            appState.setMood(mood)
        }) {
            VStack(spacing: 8) {
                Text(mood.emoji)
                    .font(.system(size: 36))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(appState.currentMood == mood ? Color.blue.opacity(0.15) : Color.white.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(appState.currentMood == mood ? Color.blue : Color.clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .scaleEffect(appear ? 1.0 : 0.8)
        .opacity(appear ? 1.0 : 0.0)
        .animation(
            .spring(response: 0.5, dampingFraction: 0.7)
                .delay(Double(Mood.allCases.firstIndex(where: { $0.id == mood.id }) ?? 0) * 0.1),
            value: appear
        )
    }
}

