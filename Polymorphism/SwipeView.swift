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
    @State private var showingNewSubjectView = false // Toggle to show NewSubjectView
    
    var body: some View {
        ZStack {
            Color(color)
            VStack {
                if index != subjects.count{
                    EmptyCircleView()
                }
                if let subject = subject {
                    Text(subject.name) // Display the current subject's name
                        .font(.largeTitle)
                        .padding()
                } else {
                    if subjects.isEmpty {
                        Text("No Subjects Available")
                    } else {
                        Text("Subject Not Set Yet")
                    }
                }
                
                // Show "Add New Subject" button when swiped to the last item + 1
                if index == subjects.count {
                    Button(action: {
                        showingNewSubjectView = true // Show the NewSubjectView
                    }) {
                        Text("Add New Subject")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if subjects.count > 0 {
                        if value.translation.width < 0 {
                            // Swipe left, move to the next subject or show "Add New Subject" button
                            index = (index + 1) % (subjects.count + 1)
                        } else if value.translation.width > 0 {
                            // Swipe right, move to the previous subject
                            index = (index - 1 + (subjects.count + 1)) % (subjects.count + 1)
                        }
                        
                        // If index is within subjects, update subject and color
                        if index < subjects.count {
                            subject = subjects[index]
                            color = subject?.hexColor ?? Color.white
                        } else {
                            subject = nil // No subject if showing "Add New Subject" button
                            color = Color.white
                        }
                    }
                }
        )
        .background(color)
        .animation(.easeInOut, value: index)
        .onAppear {
            // Initialize the first subject and color if there are subjects available
            if subjects.count > 0 {
                subject = subjects[index]
                color = subject?.hexColor ?? Color.red
            }
        }
        // Present the NewSubjectView using a sheet
        .sheet(isPresented: $showingNewSubjectView) {
            NewSubjectView()
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
