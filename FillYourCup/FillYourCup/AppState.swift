import SwiftUI

final class AppState: ObservableObject {
    @Published var tasks: [DailyTask] = SampleData.sampleTasks
    @Published var displayName: String = "Alex"
    @Published var avatarInitials: String = "A"
    @Published var avatarImageName: String? = nil

    // Onboarding flag – you can switch this to true after testing
    @Published var hasCompletedOnboarding: Bool = false

    @Published var showCelebration: Bool = false

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

    func markTaskCompleted(_ task: DailyTask) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        if tasks[index].isCompleted { return }
        
        HapticFeedback.success()
        tasks[index].isCompleted = true
        triggerCelebration()
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
}
