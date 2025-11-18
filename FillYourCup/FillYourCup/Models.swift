import Foundation
import SwiftUI

struct DailyTask: Identifiable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    let categoryIconName: String
    let explanationTitle: String
    let explanationBody: String
    var isCompleted: Bool
    var energyImpact: EnergyImpact
}

enum EnergyImpact: Codable {
    case draining
    case neutral
    case filling
}

// MARK: - Badge Model
struct Badge: Identifiable {
    let id: UUID
    let name: String
    let subtitle: String
    let icon: String
    let color: BadgeColor
    let earnedDate: Date?
    
    enum BadgeColor {
        case blue
        case green
        case pink
        
        var backgroundColor: Color {
            switch self {
            case .blue: return Color(red: 0.4, green: 0.7, blue: 1.0)
            case .green: return Color(red: 0.4, green: 0.8, blue: 0.6)
            case .pink: return Color(red: 1.0, green: 0.6, blue: 0.8)
            }
        }
        
        var circleColor: Color {
            switch self {
            case .blue: return Color(red: 0.5, green: 0.8, blue: 1.0)
            case .green: return Color(red: 0.5, green: 0.9, blue: 0.7)
            case .pink: return Color(red: 1.0, green: 0.7, blue: 0.9)
            }
        }
    }
}

// MARK: - Mood Model
enum Mood: String, CaseIterable, Identifiable {
    case happy = "😊"
    case neutral = "😐"
    case sad = "😢"
    case verySad = "😞"
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .happy: return "😊"
        case .neutral: return "😐"
        case .sad: return "😢"
        case .verySad: return "😞"
        }
    }
}

// MARK: - Weekly Goal Model
struct WeeklyGoal: Identifiable {
    let id: UUID
    let title: String
    let icon: String
    let color: Color
    let target: Int
    var current: Int
    
    var progress: Double {
        guard target > 0 else { return 0.0 }
        return Double(current) / Double(target)
    }
}