//
//  EditSubjectView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/16/24.
//

import SwiftUI
import SwiftData

struct EditSubjectView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let subject: Subject
    /**안녕하세요**/
    @State private var name = ""
    @State private var color = Color.red
    @State private var dailyGoal = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Subject Name", text: $name)
                Picker("Select a value", selection: $dailyGoal) {
                            ForEach(0..<13) { index in
                                Text("\(index * 5)")
                                    .tag(index * 5)
                            }
                        }
                        .pickerStyle(WheelPickerStyle()) // Optional: For a wheel style picker
                        .frame(height: 150)
                ColorPicker("Set the subject color", selection: $color, supportsOpacity: false)
                if changed {
                    Button("Update") {
                        subject.name = name
                        subject.color = color.toHexString()!
                        subject.dailyGoal = dailyGoal
                        dismiss()
                    }
                }
            }
            .background(color)
            .scrollContentBackground(.hidden)
//            .padding()
            .listStyle(.plain)
            .onAppear{
                name = subject.name
                dailyGoal = subject.dailyGoal
                color = subject.hexColor
            }
//            .navigationTitle("New Subject")
//            .navigationBarTitleDisplayMode(.inline)
        }
        
        var changed: Bool {
            name != subject.name ||
            dailyGoal != subject.dailyGoal ||
            color != subject.hexColor
        }
        
    }
}

#Preview {
    let preview = Preview(Subject.self)
    return NavigationStack {
        EditSubjectView(subject: Subject.sampleSubjects[2])
            .modelContainer(preview.container)
    }
}
