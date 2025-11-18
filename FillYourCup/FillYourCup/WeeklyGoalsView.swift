import SwiftUI

// MARK: - Weekly Goals View
// PURPOSE: Displays weekly goals with progress bars
// CONTRACT: Shows goals from AppState with visual progress indicators

struct WeeklyGoalsView: View {
    @EnvironmentObject var appState: AppState
    @State private var appear = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("This Week's Goals")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                ForEach(Array(appState.weeklyGoals.enumerated()), id: \.element.id) { index, goal in
                    goalRow(goal: goal)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(x: appear ? 0 : -20)
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.8)
                                .delay(Double(index) * 0.1),
                            value: appear
                        )
                }
            }
        }
        .padding(20)
        .glassmorphism(cornerRadius: 24, opacity: 0.85)
        .onAppear {
            withAnimation {
                appear = true
            }
        }
    }
    
    private func goalRow(goal: WeeklyGoal) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(goal.color.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: goal.icon)
                    .font(.system(size: 22))
                    .foregroundColor(goal.color)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(goal.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(goal.color)
                            .frame(width: geometry.size.width * CGFloat(goal.progress), height: 6)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: goal.progress)
                    }
                }
                .frame(height: 6)
            }
            
            Spacer()
            
            Text("\(goal.current)/\(goal.target)")
                .font(.headline)
                .foregroundColor(goal.color)
                .fontWeight(.semibold)
        }
    }
}

