//
//  SwipeView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/17/24.
//

import SwiftUI
import SwiftData

struct SwipeView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Query private var subjects: [Subject]
    @State private var index: Int = 0
    @State private var subject: Subject? = nil
    @State private var color = Color.white
    
    var body: some View {
        ZStack {
            Color(color)
            VStack {
//                Text("\(subjects.count)")
                
                if let subject = subject {
                    Text(subject.name) // Display the current subject's name
                        .font(.largeTitle)
                        .padding()
                } else {
                    Text("Subject Not Set Yet")
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if subjects.count > 0 {
                        // Determine swipe direction based on drag amount
                        if value.translation.width < 0 {
                            // Swipe left, move to the next subject
                            index = (index + 1) % subjects.count
                        } else if value.translation.width > 0 {
                            // Swipe right, move to the previous subject
                            index = (index - 1 + subjects.count) % subjects.count
                        }
                        
                        // Update the subject and color
                        subject = subjects[index]
                        color = subject?.hexColor ?? Color.white
                    }
                }
        )
        .background(color) // Background color based on the subject
        .animation(.easeInOut, value: index) // Smooth animation when swiping
        .onAppear {
            // Initialize the first subject and color if there are subjects available
            if subjects.count > 0 {
                subject = subjects[index]
                color = subject?.hexColor ?? Color.red
            }
        }
    }
}

#Preview {
    let preview = Preview(Subject.self)
    let subjects = Subject.sampleSubjects
    
    preview.addExamples(subjects)
    return SwipeView()
        .modelContainer(preview.container)
}
