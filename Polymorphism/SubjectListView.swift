//
//  SubjectView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/16/24.
//
// 과목들 잘 있는지 확인을 위한 뷰
// 불러오기는 성공한 것 같은데 추가하기 이런거 해야지

import SwiftUI
import SwiftData

struct SubjectListView: View {//이거 용도는
    @Environment(\.modelContext) private var modelContext
    @Query private var subjects: [Subject]
//    @Bindable var subject: Subject
    @State private var newSubject = false
    
    var body: some View {
        Group {
            if subjects.isEmpty {
                ContentUnavailableView{
                    Image(systemName: "book.fill")
                        .font(.largeTitle)
                } description: {
                    Text("No Subjects yet.")
                } actions: {
                    Button("Add Subject") {
                        newSubject.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(subjects) { subject in
                        NavigationLink {
                            EditSubjectView(subject: subject)
                        } label: {
                            Text("Lat: \(subject.name), Lon: \(subject.name)")
                                .foregroundStyle(subject.hexColor)
                        }
                    }
                    .onDelete(perform: deleteSubjects)
                }
//                .listStyle(.plain)
            }
        }
        .fullScreenCover(isPresented: $newSubject) {
            NewSubjectView()
        }
    }
//    
//    private func addSubject() {
//        withAnimation {
//                modelContext.insert(Subject(name: <#T##String#>, color: <#T##String#>))
//        }
//    }
//    
    private func deleteSubjects(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(subjects[index])
            }
        }
    }
}

#Preview {
    let preview = Preview(Subject.self)
    let subjects = Subject.sampleSubjects
//    let genres = Genre.sampleGenres
    
    preview.addExamples(subjects)
//    preview.addExamples(books)
//    books[1].genres?.append(genres[0])
//    return SubjectView(book: books[1])
    return NavigationStack{
        SubjectListView()
    }
        .modelContainer(preview.container)
}

