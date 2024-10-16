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
                    let newSubject = Subject(name: name, color: color.toHexString()!, dailyGoal: dailyGoal)
                    context.insert(newSubject)
                    dismiss()
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
