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
                            .transition(.move(edge: .top).combined(with: .opacity))
                        
                        CupCardView(
                            name: appState.displayName,
                            progress: appState.progress,
                            completed: appState.completedCount,
                            total: appState.totalCount,
                            streak: appState.currentStreak
                        )
                        .frame(height: 260)
                        .transition(.scale.combined(with: .opacity))

<<<<<<< Updated upstream
                        // Mood Check-in Section
                        MoodCheckInView()
                            .transition(.opacity)
                        
                        // Badges Section
                        if !appState.badges.isEmpty {
                            BadgesSectionView()
                                .transition(.opacity)
                        }
                        
                        // Weekly Goals Section
                        WeeklyGoalsView()
                            .transition(.opacity)
=======
                        if let suggestion = appState.aiSuggestion {
                            aiSuggestionSection(suggestionText: suggestion)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
>>>>>>> Stashed changes

                        tinyThingSection
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                        tasksSection
                            .transition(.opacity)
                        
                        moodSection
                            .transition(.opacity)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
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
                Text("Let's fill your cup today ✨")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            ZStack {
                if let avatarImageName = appState.avatarImageName {
                    AsyncImage(url: URL(string: avatarImageName)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Circle()
                            .fill(Color.purple.opacity(0.2))
                            .overlay(
                                Text(appState.avatarInitials)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            )
                    }
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(appState.avatarInitials)
                                .font(.headline)
                                .fontWeight(.semibold)
                        )
                }

                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .offset(x: 16, y: 16)
            }
        }
        .padding(.top, 16)
    }

    private var tinyThingSection: some View {
        VStack(alignment: .leading, spacing: 16) {
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
            
            VStack(spacing: 12) {
                tinyThingButton(
                    title: "Take a 5-minute walk",
                    icon: "figure.walk",
                    color: .green
                ) {
                    // Action for walk
                }
                
                tinyThingButton(
                    title: "Text a friend",
                    icon: "bubble.left.and.bubble.right.fill",
                    color: .blue
                ) {
                    // Action for text
                }
                
                tinyThingButton(
                    title: "2-minute breathing",
                    icon: "wind",
                    color: .purple
                ) {
                    // Action for breathing
                }
            }
        }
        .padding(16)
        .glassmorphism(cornerRadius: 24, opacity: 0.8)
    }
    
    private func tinyThingButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            HapticFeedback.medium()
            action()
        }) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18))
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(color.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(color.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(AnimatedButtonStyle(scale: 0.96))
    }

    private func aiSuggestionSection(suggestionText: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "sparkles")
                .font(.title3)
                .foregroundColor(.purple)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                Text("A Tip from AI USM")
                    .font(.headline)
                    .fontWeight(.bold)
                Text(suggestionText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                )
        )
    }

    private var tasksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(appState.tasks.enumerated()), id: \.element.id) { index, task in
                taskRow(task)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    ))
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.7)
                            .delay(Double(index) * 0.05),
                        value: appState.tasks
                    )
            }
        }
    }

    private func taskRow(_ task: DailyTask) -> some View {
        Button(action: {
            HapticFeedback.selection()
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
                .scaleEffect(task.isCompleted ? 1.1 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: task.isCompleted)

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.body)
                        .foregroundColor(.primary)
                        .strikethrough(task.isCompleted)
                    Text(task.subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "chevron.right")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .scaleEffect(task.isCompleted ? 1.2 : 1.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: task.isCompleted)
            }
            .padding(16)
            .glassmorphism(cornerRadius: 24, opacity: 0.85)
        }
        .buttonStyle(ScaleButtonStyle())
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

            Button(action: {
                HapticFeedback.success()
            }) {
                Text("Save mood")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.purple.opacity(0.2),
                                Color.blue.opacity(0.2)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(18)
            }
            .buttonStyle(AnimatedButtonStyle(scale: 0.97))
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
