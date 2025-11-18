import Foundation
import SwiftUI

final class AppState: ObservableObject {
    @Published var tasks: [DailyTask] = SampleData.sampleTasks
    @Published var displayName: String = "Alex"
    @Published var avatarInitials: String = "A"
    @Published var avatarImageName: String? = nil // Для поддержки изображений

    // Celebration flag when a task is completed
    @Published var showCelebration: Bool = false
    @Published var animatedProgress: Double = 0.0 // Для анимации прогресса

    // MARK: - Derived values

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
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            tasks[index].isCompleted = true
            updateAnimatedProgress()
        }
        
        triggerCelebration()
    }
    
    private func updateAnimatedProgress() {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
            animatedProgress = progress
        }
    }
    
    init() {
        let initialProgress = SampleData.sampleTasks.isEmpty ? 0.0 : 
            Double(SampleData.sampleTasks.filter { $0.isCompleted }.count) / Double(SampleData.sampleTasks.count)
        animatedProgress = initialProgress
    }

    private func triggerCelebration() {
        showCelebration = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut(duration: 0.3)) {
                self.showCelebration = false
            }
        }
    }
}
