import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                HStack(spacing: 16) {
                    Circle()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Text(appState.avatarInitials)
                                .font(.title2)
                                .fontWeight(.semibold)
                        )

                    VStack(alignment: .leading) {
                        Text(appState.displayName)
                            .font(.headline)
                        Text("Prototype user")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}
