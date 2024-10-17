//
//  EmptyCircleView.swift
//  Kassy
//
//  Created by Ouimin Lee on 9/11/24.
//
import SwiftUI

struct EmptyCircleView: View {
    @State private var timeRemaining = 0  // Start with an empty pie (0 seconds)
    @State private var timerIsRunning = false  // Timer is paused by default
    @State private var displayedValue: Int = 0 // Starts at 0 for an empty pie
    @State private var startTime: Date?  // To track when the timer started
    
    let initialTime = 3600  // Maximum value
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium) // Haptic feedback generator
    
    var body: some View {
        VStack {
            // Display countdown timer
            Text("\(timeRemaining)")
                .font(.largeTitle)
                .padding()
            Text(formatTime(timeRemaining))
                .font(.largeTitle)
                .padding()
            Text("Set time: \(formatTime(displayedValue).prefix(2)) mins")
                .font(.largeTitle)
                .padding()
            
            // Display Pie shape that increases as the user swipes up
            ZStack {
                // Background white circle
                Circle()
                    .fill(Color.white)
                    .frame(width: 200, height: 200)
                //                    .gesture(
                //                        DragGesture()
                //                            .onChanged { value in
                //                                let dragDistance = value.translation.height
                //                                // Calculate minutes to add/subtract based on drag distance (e.g., each 10 pts = 1 min)
                //                                let minuteIncrement = Int(dragDistance / 50)  // Change scale factor for fine control
                //                                let scaledValue = displayedValue - minuteIncrement * 60 // Convert minutes to seconds
                //                                displayedValue = max(0, min(initialTime, scaledValue)) // Clamp between 0 and 3600 seconds
                //                                timeRemaining = displayedValue
                //                            }
                //                    )
                    .gesture(timeAdjustmentGesture)
                    .animation(.easeInOut, value: displayedValue)
                
                // Shrinking pie chart
                Pie(startAngle: .degrees(-90),
                    // Calculate endAngle for clockwise shrinking as timeRemaining decreases
                    //                    endAngle: .degrees(-90 + (Double(timeRemaining) / Double(initialTime)) * 360),
                    endAngle: .degrees(-90 - (Double(timeRemaining) / Double(initialTime)) * 360),
                    clockwise: true)  // Now the pie will shrink clockwise
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .gesture(timeAdjustmentGesture)
                .animation(.easeInOut, value: timeRemaining)
            }
            .padding()
            .onAppear(perform: resetTimer)
            .onChange(of: displayedValue) {
                if !timerIsRunning && timeRemaining > 0 {
                    startTimer()
                }
            }
            
            // Control buttons for pausing, resuming, and resetting the timer
            Text("Elapsed time: \(elapsedTime)")
                .font(.headline)
                .padding()
            HStack {
                if timerIsRunning {
                    Button("Pause") {
                        timerIsRunning = false
                    }
                    .padding()
                } else {
                    Button("Resume") {
                        if timeRemaining > 0 {
                            timerIsRunning = true
                        }
                    }
                    .padding()
                }
                
                Button("Reset") {
                    resetTimer()
                }
                .padding()
            }
        }
    }
    
    // Timer function to update timeRemaining and pie chart
    func startTimer() {
        timerIsRunning = true
        startTime = Date()  // Record the start time
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeRemaining > 0 && self.timerIsRunning {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    // Function to reset the timer
    func resetTimer() {
        timeRemaining = 0  // Start with an empty pie
        displayedValue = 0  // Displayed value also starts at 0
        timerIsRunning = false
        startTime = nil  // Clear the start time
    }
    
    // Helper function to format timeRemaining as mm:ss
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)  // Display as mm:ss
    }
    
    private var elapsedTime: String {
        guard let startTime = startTime else { return "00:00" }
        let elapsedSeconds = Int(Date().timeIntervalSince(startTime))
        return formatTime(elapsedSeconds)
    }
    
    var timeAdjustmentGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let dragDistance = value.translation.height
                // Calculate minutes to add/subtract based on drag distance (e.g., each 10 pts = 1 min)
                let minuteIncrement = Int(dragDistance / 100)  // Change scale factor for fine control
                let scaledValue = displayedValue - minuteIncrement * 60 // Convert minutes to seconds
                displayedValue = max(0, min(initialTime, scaledValue)) // Clamp between 0 and 3600 seconds
                timeRemaining = displayedValue
                // Trigger haptic feedback
                feedbackGenerator.impactOccurred()
            }
            .onEnded { _ in
                // Prepare the feedback generator for the next time
                feedbackGenerator.prepare()
            }
    }
}

// Preview for Xcode
#Preview {
    EmptyCircleView()
}
