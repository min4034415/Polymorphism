//
//  Subject.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/23/24.
//
// 이거는 무엇이냐면 뭐냐고 물어보면 이거는 뭐냐고 물어보면 과목 그리고 목표시간 일일 목표시간 월별 목표시간

import SwiftUI
import SwiftData

@Model
final class Subject {
    @Attribute(.unique)
    var name: String
    var color: String
    var dailyGoal: Int
    var rogueones: [RogueOne]?
    
    init(
        name: String,
        color: String,
        dailyGoal: Int,
        rogueones: [RogueOne]? = nil
    ) {
        self.name = name
        self.color = color
        self.dailyGoal = dailyGoal
        self.rogueones = rogueones
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
