import Foundation
import SwiftUI

enum SampleData {
    static let sampleTasks: [DailyTask] = [
        DailyTask(
            id: UUID(),
            title: "Take a 5-minute walk",
            subtitle: "Move • 5 min",
            categoryIconName: "figure.walk",
            explanationTitle: "Why a short walk helps",
            explanationBody: """
A brief walk gently activates the body without demanding much energy. Even a few minutes of movement can increase blood flow, wake up the nervous system, and nudge the brain to release dopamine and endorphins. These signals tell the brain that the body is safe and active, which can reduce feelings of heaviness and improve mood for the next hour.
""",
            isCompleted: false,
            energyImpact: .filling
        ),
        DailyTask(
            id: UUID(),
            title: "Text a friend",
            subtitle: "Connect • 2 min",
            categoryIconName: "bubble.left.and.bubble.right.fill",
            explanationTitle: "Why reaching out matters",
            explanationBody: """
Depression often pushes people to withdraw, even when they want connection. Sending a short message is a low-pressure way to signal to your brain that you are not alone. Small social interactions can reduce perceived isolation and activate reward circuits related to belonging and support.
""",
            isCompleted: false,
            energyImpact: .filling
        ),
        DailyTask(
            id: UUID(),
            title: "2-minute breathing",
            subtitle: "Calm • 2 min",
            categoryIconName: "wind",
            explanationTitle: "Why slow breathing helps",
            explanationBody: """
Slow, steady breathing activates the parasympathetic nervous system, the part responsible for recovery and calm. When you extend the exhale, the heart rate slightly slows down and the body receives a physical signal that the situation is safe enough to relax. This can reduce anxiety and make the next task feel more doable.
""",
            isCompleted: false,
            energyImpact: .filling
        ),
        DailyTask(
            id: UUID(),
            title: "Make your bed",
            subtitle: "Structure • 3 min",
            categoryIconName: "bed.double.fill",
            explanationTitle: "Why making the bed matters",
            explanationBody: """
Completing a small, clearly defined task gives the brain a sense of closure and mastery. This can release a small amount of dopamine, the chemical that signals that effort was worthwhile. A made bed also adds structure to the environment, which helps anchor the day when motivation is low.
""",
            isCompleted: false,
            energyImpact: .neutral
        )
    ]
    
    static let sampleWeeklyGoals: [WeeklyGoal] = [
        WeeklyGoal(
            id: UUID(),
            title: "Move your body 3 times",
            icon: "figure.run",
            color: Color(red: 0.4, green: 0.7, blue: 1.0),
            target: 3,
            current: 2
        ),
        WeeklyGoal(
            id: UUID(),
            title: "Reach out to 2 people",
            icon: "person.2.fill",
            color: Color(red: 0.4, green: 0.8, blue: 0.6),
            target: 2,
            current: 1
        ),
        WeeklyGoal(
            id: UUID(),
            title: "Try 1 calming practice",
            icon: "lotus",
            color: Color(red: 1.0, green: 0.6, blue: 0.8),
            target: 1,
            current: 0
        )
    ]
}
