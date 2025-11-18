import Foundation

// MARK: - AI USM Service
// PURPOSE: Centralized logic for the AI assistant 'AI USM'.
// CONTRACT: Provides proactive suggestions based on user's tasks.

struct AIService {
    
    /// Analyzes the user's current tasks and provides a suggestion if needed.
    /// - Parameter tasks: The list of tasks for the day.
    /// - Returns: An optional `AISuggestion` string if a suggestion is warranted, otherwise nil.
    func getSuggestion(for tasks: [DailyTask]) -> String? {
        
        // --- Stage 1: Basic Logic (Placeholder) ---
        // In the future, this will be replaced by a CoreML model analysis.
        
        let drainingTasksCount = tasks.filter { $0.energyImpact == .draining }.count
        let incompleteTasksCount = tasks.filter { !$0.isCompleted }.count

        // Rule 1: If there are many draining tasks.
        if drainingTasksCount >= 2 {
            return "I see you have a few challenging tasks today. Remember to take a short break to recharge."
        }
        
        // Rule 2: If many tasks are still pending towards the end of the day (placeholder for time logic).
        if incompleteTasksCount >= 4 {
            return "There's a lot on your plate. Focus on one small step at a time. You can do it!"
        }
        
        // --- Add more rules as we develop the logic ---
        
        return nil // No suggestion needed at the moment.
    }
}
