import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var tasks: [DailyTask] = SampleData.sampleTasks {
        didSet {
            updateAISuggestion()
        }
    }
    @Published var displayName: String = "Alex"
    @Published var avatarInitials: String = "A"
    @Published var avatarImageName: String? = nil

    // AI USM Integration
    @Published var aiSuggestion: String?
    private let aiService = AIService()

    // Onboarding flag – you can switch this to true after testing
    @Published var hasCompletedOnboarding: Bool = false

    @Published var showCelebration: Bool = false
    
    // Badges
    @Published var badges: [Badge] = []
    
    // Mood tracking
    @Published var currentMood: Mood? = nil
    @Published var moodHistory: [Date: Mood] = [:]
    
    // Weekly goals
    @Published var weeklyGoals: [WeeklyGoal] = SampleData.sampleWeeklyGoals
    
    // Streak tracking
    @Published var currentStreak: Int = 0
    @Published var lastCompletedDate: Date? = nil

    var completedCount: Int {
        tasks.filter { $0.isCompleted }.count
    }

    var totalCount: Int {
        tasks.count
    }

    var progress: Double {
        guard totalCount > 0 else { return 0.0 }
        return Double(completedCount) / Double(totalCount)
    }

    init() {
        updateAISuggestion()
    }

    func markTaskCompleted(_ task: DailyTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        if tasks[index].isCompleted { return }
        
        HapticFeedback.success()
        tasks[index].isCompleted = true
        
        // Update streak
        updateStreak()
        
        // Check for badges
        checkAndAwardBadges()
        
        // Update weekly goals
        updateWeeklyGoals(for: task)
        
        triggerCelebration()
    }
    
    func setMood(_ mood: Mood) {
        currentMood = mood
        moodHistory[Date()] = mood
        HapticFeedback.selection()
    }
    
    private func updateStreak() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let lastDate = lastCompletedDate {
            let lastDay = Calendar.current.startOfDay(for: lastDate)
            let daysSince = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 0
            
            if daysSince == 0 {
                // Already completed today
                return
            } else if daysSince == 1 {
                // Consecutive day
                currentStreak += 1
            } else {
                // Streak broken
                currentStreak = 1
            }
        } else {
            // First completion
            currentStreak = 1
        }
        
        lastCompletedDate = today
    }
    
    private func checkAndAwardBadges() {
        let today = Calendar.current.startOfDay(for: Date())
        
        // First Sip badge - 3 tasks completed today
        if completedCount >= 3 {
            let badgeName = "First Sip"
            if !badges.contains(where: { $0.name == badgeName }) {
                badges.append(Badge(
                    id: UUID(),
                    name: badgeName,
                    subtitle: "\(completedCount) tasks today",
                    icon: "drop.fill",
                    color: .green,
                    earnedDate: today
                ))
            }
        }
        
        // Steady Stream badge - 4 day streak
        if currentStreak >= 4 {
            let badgeName = "Steady Stream"
            if !badges.contains(where: { $0.name == badgeName }) {
                badges.append(Badge(
                    id: UUID(),
                    name: badgeName,
                    subtitle: "\(currentStreak) day streak",
                    icon: "flame.fill",
                    color: .blue,
                    earnedDate: today
                ))
            }
        }
        
        // Early Bird badge - morning task
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 && completedCount > 0 {
            let badgeName = "Early Bird"
            if !badges.contains(where: { $0.name == badgeName }) {
                badges.append(Badge(
                    id: UUID(),
                    name: badgeName,
                    subtitle: "Morning task",
                    icon: "star.fill",
                    color: .pink,
                    earnedDate: today
                ))
            }
        }
    }
    
    private func updateWeeklyGoals(for task: DailyTask) {
        // Update weekly goals based on task category
        for index in weeklyGoals.indices {
            var goal = weeklyGoals[index]
            
            if task.categoryIconName == "figure.walk" && goal.icon == "figure.run" {
                goal.current = min(goal.current + 1, goal.target)
            } else if task.categoryIconName == "bubble.left.and.bubble.right.fill" && goal.icon == "person.2.fill" {
                goal.current = min(goal.current + 1, goal.target)
            } else if task.categoryIconName == "wind" && goal.icon == "lotus" {
                goal.current = min(goal.current + 1, goal.target)
            }
            
            weeklyGoals[index] = goal
        }
    }
    
    var recentBadges: [Badge] {
        badges.suffix(3).reversed()
    }

    private func triggerCelebration() {
        showCelebration = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeOut(duration: 0.3)) {
                self.showCelebration = false
            }
        }
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    // MARK: - AI USM Logic
    private func updateAISuggestion() {
        self.aiSuggestion = aiService.getSuggestion(for: self.tasks)
    }
}
