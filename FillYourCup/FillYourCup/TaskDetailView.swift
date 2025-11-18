import SwiftUI

struct TaskDetailView: View {
    let task: DailyTask
    let onComplete: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var appear = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Task icon
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(getTaskColor().opacity(0.2))
                                .frame(width: 60, height: 60)
                            Image(systemName: task.categoryIconName)
                                .font(.system(size: 28))
                                .foregroundColor(getTaskColor())
                        }
                        .scaleEffect(appear ? 1.0 : 0.5)
                        .opacity(appear ? 1.0 : 0.0)
                        
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    Text(task.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(x: appear ? 0 : -20)

                    Text(task.subtitle)
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(x: appear ? 0 : -20)

                    Divider()
                        .opacity(appear ? 1.0 : 0.0)

                    Text(task.explanationTitle)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(y: appear ? 0 : 10)

                    Text(task.explanationBody)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                        .opacity(appear ? 1.0 : 0.0)
                        .offset(y: appear ? 0 : 10)

                    Spacer(minLength: 24)

                    Button(action: markDone) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Mark as done")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.purple,
                                    Color.blue
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .buttonStyle(AnimatedButtonStyle(scale: 0.97))
                    .padding(.top, 8)
                    .opacity(appear ? 1.0 : 0.0)
                    .offset(y: appear ? 0 : 20)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Why this helps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        HapticFeedback.light()
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appear = true
            }
        }
    }

    private func markDone() {
        HapticFeedback.success()
        onComplete()
        dismiss()
    }
    
    private func getTaskColor() -> Color {
        if task.categoryIconName == "figure.walk" {
            return .green
        } else if task.categoryIconName == "bubble.left.and.bubble.right.fill" {
            return .blue
        } else if task.categoryIconName == "wind" {
            return .purple
        } else {
            return .gray
        }
    }
}
