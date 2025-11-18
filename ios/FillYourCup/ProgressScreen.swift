import SwiftUI

struct ProgressScreen: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your Progress")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                HStack(spacing: 16) {
                    statCard(
                        title: "\(appState.completedCount)",
                        subtitle: "Tasks completed today",
                        systemImage: "checkmark.circle.fill"
                    )
                    statCard(
                        title: String(format: "%.0f%%", appState.progress * 100),
                        subtitle: "Cup filled today",
                        systemImage: "cup.and.saucer.fill"
                    )
                }

                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }

    private func statCard(title: String, subtitle: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 22))
                .foregroundColor(.purple)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}
