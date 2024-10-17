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
    @State private var subject: Subject?
    @State private var color = Color.red
    
    var body: some View {
        ZStack {
            Color(color)
            VStack {
                Text("\(subjects.count)")
                
                if subjects.count > 0 {
                    Text(subjects[index].name) // Display the current subject's name
                        .font(.largeTitle)
                        .padding()
                } else {
                    Text("No subjects available")
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Determine swipe direction based on drag amount
                    if value.translation.width < 0 {
                        // Swipe left, move to the next subject
                        index = (index + 1) % subjects.count
                    } else if value.translation.width > 0 {
                        // Swipe right, move to the previous subject
                        index = (index - 1 + subjects.count) % subjects.count
                    }
                    
                    // Update the subject and color
                    if subjects.count > 0 {
                        subject = subjects[index]
                        color = subject?.hexColor ?? Color.red
                    }
                }
        )
        .background(color) // Background color based on the subject
        .animation(.easeInOut, value: index) // Smooth animation when swiping
    }
}

#Preview {
    let preview = Preview(Subject.self)
    let subjects = Subject.sampleSubjects
    
    preview.addExamples(subjects)
    return SwipeView()
        .modelContainer(preview.container)
}
