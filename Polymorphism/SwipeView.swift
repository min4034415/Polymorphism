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
    //    @State private var subject = subjects[index]
    @State private var subject: Subject?
    @State private var color = Color.red
    
    var body: some View {
        //            Color(color)
        ZStack {
            Color(color)
            VStack {
                Button {
                    // Action to perform when the button is pressed
                    if subjects.count > 0 {
                        index = (index + 1) % subjects.count
                        subject = subjects[index]
                        color = subject!.hexColor
                    }
                } label: {
                    Text("Next Subject") // Button label
                }
                
                Text("\(subjects.count)")
                if subjects.count > 1 {
                    Text(subjects[index].name) // Access the name of the second subject
                } else {
                    Text("No second subject available") // Handle case when there's no second subject
                }
            }
        }.background(color)
    }
}
//        .foreground(.red)
//        .foreground(.red)
        

#Preview {
    let preview = Preview(Subject.self)
    let subjects = Subject.sampleSubjects
//    let genres = Genre.sampleGenres
    
    preview.addExamples(subjects)
    return SwipeView()
        .modelContainer(preview.container)
}
