//
//  PolymorphismApp.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/10/24.
//

import SwiftUI
import SwiftData

@main
struct PolymorphismApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            RogueOne.self,
            Subject.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            OptionalView()
//            NewSubjectView()
//                SubjectListView()
//                    .modelContainer(for: [Subject.self])
            SwipeView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
