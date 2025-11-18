import SwiftUI

struct TaskDetailView: View {
    let task: DailyTask
    let onComplete: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(task.title)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(task.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    Text(task.explanationTitle)
                        .font(.headline)

                    Text(task.explanationBody)
                        .font(.body)
                        .foregroundColor(.primary)

                    Spacer(minLength: 24)

                    Button(action: markDone) {
                        Text("Mark as done")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Why this helps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func markDone() {
        onComplete()
        dismiss()
    }
}
