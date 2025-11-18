import SwiftUI

struct RootTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)

            ProgressScreen()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Progress")
                }
                .tag(1)

            ScheduleScreen()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
                .tag(2)

            ProfileScreen()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(.purple)
    }
}

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    @State private var selectedTask: DailyTask?
    @State private var moodValue: Double = 5.0

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        headerSection
                        CupCardView(
                            name: appState.displayName,
                            progress: appState.progress,
                            completed: appState.completedCount,
                            total: appState.totalCount
                        )
                        .frame(height: 260)

                        tinyThingSection
                        tasksSection
                        moodSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
                .background(Color(.systemGroupedBackground))
                .navigationBarHidden(true)
            }

            if appState.showCelebration {
                CelebrationOverlay()
                    .allowsHitTesting(false)
                    .transition(.opacity)
            }
        }
        .sheet(item: $selectedTask) { task in
            TaskDetailView(task: task) {
                appState.markTaskCompleted(task)
            }
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(greetingTitle())
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Let us fill your cup today")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 44, height: 44)

                Text(appState.avatarInitials)
                    .font(.headline)
                    .fontWeight(.semibold)

                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .offset(x: 16, y: 16)
            }
        }
        .padding(.top, 16)
    }

    private var tinyThingSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.15))
                        .frame(width: 32, height: 32)
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(.purple)
                }
                Text("Choose one tiny thing")
                    .font(.headline)
            }

            Text("What would help fill your cup this afternoon?")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
        )
    }

    private var tasksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(appState.tasks) { task in
                taskRow(task)
            }
        }
    }

    private func taskRow(_ task: DailyTask) -> some View {
        Button(action: {
            selectedTask = task
        }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backgroundColor(for: task))
                        .frame(width: 40, height: 40)
                    Image(systemName: task.categoryIconName)
                        .foregroundColor(iconColor(for: task))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.body)
                        .foregroundColor(.primary)
                    Text(task.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "chevron.right")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("How are you feeling right now?")
                .font(.headline)

            HStack {
                Text("Low")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Slider(value: $moodValue, in: 1...10, step: 1)
                Text("High")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Button(action: {}) {
                Text("Save mood")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(18)
            }
        }
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func greetingTitle() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let prefix: String
        if hour < 12 {
            prefix = "Good morning"
        } else if hour < 18 {
            prefix = "Good afternoon"
        } else {
            prefix = "Good evening"
        }
        return "\(prefix), \(appState.displayName)"
    }

    private func backgroundColor(for task: DailyTask) -> Color {
        if task.categoryIconName == "figure.walk" {
            return Color.green.opacity(0.15)
        } else if task.categoryIconName == "bubble.left.and.bubble.right.fill" {
            return Color.blue.opacity(0.15)
        } else if task.categoryIconName == "wind" {
            return Color.purple.opacity(0.15)
        } else {
            return Color.gray.opacity(0.12)
        }
    }

    private func iconColor(for task: DailyTask) -> Color {
        if task.categoryIconName == "figure.walk" {
            return Color.green
        } else if task.categoryIconName == "bubble.left.and.bubble.right.fill" {
            return Color.blue
        } else if task.categoryIconName == "wind" {
            return Color.purple
        } else {
            return Color.gray
        }
    }
}
