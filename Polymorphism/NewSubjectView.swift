//
//  NewSubjectView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/16/24.
//

import SwiftUI
import SwiftData

struct NewSubjectView: View {
    @State private var name = ""
    @State private var color = Color.red
    @State private var dailyGoal = 0
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    
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
                Button("Create") {
                                 // Trim whitespaces from the name
                                 let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                                 
                                 // Check if the trimmed name is empty
                                 if trimmedName.isEmpty {
                                     showAlert = true // Show an alert if the input is invalid
                                 } else {
                                     let newSubject = Subject(name: trimmedName, color: color.toHexString()!, dailyGoal: dailyGoal)
                                     context.insert(newSubject)
                                     dismiss()
                                 }
                             }
                             .alert(isPresented: $showAlert) {
                                 Alert(title: Text("Invalid Input"),
                                       message: Text("Subject name cannot be empty or contain only spaces."),
                                       dismissButton: .default(Text("OK")))
                             }
            }
            .background(color)
            .scrollContentBackground(.hidden)
//            .padding()
            .listStyle(.plain)
//            .navigationTitle("New Subject")
//            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    NewSubjectView()
}
