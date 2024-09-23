//
//  Subject.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/23/24.
//
// 이거는 무엇이냐면 뭐냐고 물어보면 이거는 뭐냐고 물어보면 과목 그리고 목표시간 일일 목표시간 월별 목표시간

import Foundation
import SwiftData

@Model
final class Subject {
    var timestamp: Date
    var id: UUID
    
    init(timestamp: Date, id: UUID)
    {
        self.timestamp = timestamp
        self.id = id
    }
}
