import SwiftUI

struct ScheduleScreen: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("In this prototype, tasks are shown on the Home tab. A future version can place tasks and reminders on a timeline here.")
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}
