import Foundation

struct DailyTask: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let categoryIconName: String
    let explanationTitle: String
    let explanationBody: String
    var isCompleted: Bool
}
