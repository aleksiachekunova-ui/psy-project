import Foundation
import SwiftUI

final class AppState: ObservableObject {
    @Published var tasks: [DailyTask] = SampleData.sampleTasks
    @Published var displayName: String = "Alex"
    @Published var avatarInitials: String = "A"

    // Celebration flag when a task is completed
    @Published var showCelebration: Bool = false

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
}
