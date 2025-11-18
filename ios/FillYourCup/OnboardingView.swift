import SwiftUI

// MARK: - Onboarding View
// PURPOSE: Initial questionnaire to personalize user experience
// CONTRACT: Collects user name, mood patterns, and preferences

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentStep = 0
    @State private var userName: String = ""
    @State private var selectedMoodPattern: MoodPattern = .low
    @State private var selectedGoals: Set<WellnessGoal> = []
    
    enum MoodPattern: String, CaseIterable {
        case low = "Often low"
        case fluctuating = "Up and down"
        case stable = "Generally stable"
        
        var description: String {
            switch self {
            case .low: return "I often feel low or unmotivated"
            case .fluctuating: return "My mood changes throughout the day"
            case .stable: return "I'm generally doing okay"
            }
        }
    }
    
    enum WellnessGoal: String, CaseIterable {
        case movement = "Move more"
        case connection = "Connect with others"
        case calm = "Find calm"
        case structure = "Build routine"
        
        var icon: String {
            switch self {
            case .movement: return "figure.walk"
            case .connection: return "person.2.fill"
            case .calm: return "wind"
            case .structure: return "calendar"
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.93, green: 0.95, blue: 1.0),
                    Color(red: 0.96, green: 0.93, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if currentStep == 0 {
                    welcomeStep
                } else if currentStep == 1 {
                    nameStep
                } else if currentStep == 2 {
                    moodPatternStep
                } else if currentStep == 3 {
                    goalsStep
                } else {
                    completionStep
                }
            }
        }
    }
    
    // MARK: - Steps
    
    private var welcomeStep: some View {
        VStack(spacing: 32) {
            Spacer()
            
            CupView(progress: 0.0)
                .frame(height: 200)
            
            VStack(spacing: 16) {
                Text("Welcome to")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Fill Your Cup")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Small steps, big changes")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    currentStep = 1
                }
            }) {
                Text("Get Started")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(AnimatedButtonStyle(scale: 0.97))
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
    
    private var nameStep: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 16) {
                Text("What should we call you?")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("We'll use this to personalize your experience")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            TextField("Your name", text: $userName)
                .textFieldStyle(.roundedBorder)
                .font(.title3)
                .padding(.horizontal, 40)
                .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                if !userName.isEmpty {
                    withAnimation {
                        currentStep = 2
                    }
                }
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(userName.isEmpty ? Color.gray : LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(AnimatedButtonStyle(scale: 0.97))
            .disabled(userName.isEmpty)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
    
    private var moodPatternStep: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("How would you describe your mood patterns?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                
                Text("This helps us tailor tasks to your needs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            VStack(spacing: 16) {
                ForEach(MoodPattern.allCases, id: \.self) { pattern in
                    Button(action: {
                        HapticFeedback.selection()
                        selectedMoodPattern = pattern
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(pattern.rawValue)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(pattern.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if selectedMoodPattern == pattern {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.purple)
                                    .font(.title3)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(selectedMoodPattern == pattern ? Color.purple.opacity(0.1) : Color.white.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(selectedMoodPattern == pattern ? Color.purple : Color.clear, lineWidth: 2)
                                )
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    currentStep = 3
                }
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(AnimatedButtonStyle(scale: 0.97))
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
    
    private var goalsStep: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("What would help fill your cup?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                
                Text("Select all that apply")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            VStack(spacing: 16) {
                ForEach(WellnessGoal.allCases, id: \.self) { goal in
                    Button(action: {
                        HapticFeedback.selection()
                        if selectedGoals.contains(goal) {
                            selectedGoals.remove(goal)
                        } else {
                            selectedGoals.insert(goal)
                        }
                    }) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(selectedGoals.contains(goal) ? Color.purple.opacity(0.2) : Color.gray.opacity(0.1))
                                    .frame(width: 50, height: 50)
                                Image(systemName: goal.icon)
                                    .foregroundColor(selectedGoals.contains(goal) ? .purple : .gray)
                            }
                            
                            Text(goal.rawValue)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if selectedGoals.contains(goal) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.purple)
                                    .font(.title3)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(selectedGoals.contains(goal) ? Color.purple.opacity(0.1) : Color.white.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(selectedGoals.contains(goal) ? Color.purple : Color.clear, lineWidth: 2)
                                )
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                completeOnboarding()
            }) {
                Text("Complete Setup")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(AnimatedButtonStyle(scale: 0.97))
            .disabled(selectedGoals.isEmpty)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
    
    private var completionStep: some View {
        VStack(spacing: 32) {
            Spacer()
            
            CupView(progress: 1.0)
                .frame(height: 200)
            
            VStack(spacing: 16) {
                Text("You're all set!")
                    .font(.system(size: 36, weight: .bold))
                
                Text("Let's start filling your cup")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                appState.completeOnboarding()
            }
        }
    }
    
    // MARK: - Helpers
    
    private func completeOnboarding() {
        HapticFeedback.success()
        
        // Update app state
        appState.displayName = userName.isEmpty ? "Friend" : userName
        appState.avatarInitials = String(userName.prefix(1).uppercased())
        
        // Customize tasks based on goals (simplified for prototype)
        // In full implementation, this would filter/prioritize tasks
        
        withAnimation {
            currentStep = 4
        }
    }
}

