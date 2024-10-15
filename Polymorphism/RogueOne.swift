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
    var id: UUID //고유 id
    var timestamp: Date = Date.now// 시작 시간
    var latitude: Double? // 위도
    var longitude: Double? // 경도
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
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date.now,
        latitude: Double? = nil,
        longitude: Double? = nil,
        status: Status = .running
    ) {
        self.id = id
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
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

