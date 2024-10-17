//
//  RogueOne.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/14/24.
//
// 유니크한 타이머 로그파일
// 뭐가 있어야 하냐면 타이머를 액세스 할 uuid 경과 시간 목표 시간 이런거

import SwiftData
import MapKit
import SwiftUI

@Model
class RogueOne {
    var id: UUID //고유 id 타이머 아이디
    var timestamp: Date = Date.now// 시작 시간
    var allocated_time : Double? // 할당 시간
    var elapsed_time : Double? // 소요 시간
    var latitude: Double? // 위도
    var longitude: Double? // 경도
    var end_time: Double? // 마감시간
    var time_left: Double? // 잔여시간
//    var subject_name: Double? // 과목이름
    @Relationship(deleteRule: .cascade)
//    var subject: [Subject]?
    var subject: Subject?
    //    var subject: UUID // 이걸 어케해야하오
    //이건 One to many 인가 아니면 many to one 인가
    var coordinate: CLLocationCoordinate2D? {
            get {
                if let lat = latitude, let lon = longitude {
                    return CLLocationCoordinate2D(latitude: lat, longitude: lon)
                } else {
                    return nil
                }
            }
            set {
                latitude = newValue?.latitude
                longitude = newValue?.longitude
            }
        }
    var status: Status
    var icon: Image {
        switch status {
        case.notStarted:
            Image(systemName: "square.dashed")
        case .running:
            Image(systemName: "pause.fill")
        case .paused:
            Image(systemName: "play.fill")
        case .completed:
            Image(systemName: "checkmark.rectangle.portrait")
        }
    }
    
//    init(
//        id: UUID = UUID(),
//        timestamp: Date = Date.now,
//        latitude: Double? = nil,
//        longitude: Double? = nil,
//        status: Status = .running
//    ) {
//        self.id = id
//        self.timestamp = timestamp
//        self.latitude = latitude
//        self.longitude = longitude
//        self.status = status
//    }
    init(
        id: UUID = UUID(),
        timestamp: Date = Date.now,
        allocated_time: Double? = nil,
        elapsed_time: Double? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        end_time: Double? = nil,
        time_left: Double? = nil,
//        subject_name: Double? = nil,
        status: Status = .notStarted
    ) {
        self.id = id
        self.timestamp = timestamp
        self.allocated_time = allocated_time
        self.elapsed_time = elapsed_time
        self.latitude = latitude
        self.longitude = longitude
        self.end_time = end_time
        self.time_left = time_left
//        self.subject_name = subject_name
        self.status = status
    }
    
    enum Status: Int, Codable, Identifiable, CaseIterable {
    case notStarted, running, paused, completed
        var id: Self {
            self
        }
        var descr: String {
            switch self {
            case.notStarted:
                "Not Started"
            case .running:
                "Running"
            case .paused:
                "Paused"
            case .completed:
                "Completed"
            }
        }
    }
}

