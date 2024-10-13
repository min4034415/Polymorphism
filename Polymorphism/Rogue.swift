//
//  Log.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/23/24.
//
// 유니크한 타이머 로그파일
// 뭐가 있어야 하냐면 타이머를 액세스 할 uuid 경과 시간 목표 시간 이런거
//

import Foundation
import SwiftData
import CoreLocation
import SwiftUI

@Model
final class Rogue {
    var id: UUID //고유 id
    var timestamp: Date // 시작 시간
    var latitude: Double // 위도
    var longitude: Double // 경도
//    var subject: UUID // 이걸 어케해야하오
    //이건 One to many 인가 아니면 many to one 인가
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    var status: Status
    var icon: Image {
        switch status {
        case .running:
            Image(systemName: "pause.fill")
        case .paused:
            Image(systemName: "play.fill")
        case .completed:
            Image(systemName: "checkmark.rectangle.portrait")
        }
    }
    
//    init(timestamp: Date, id: UUID, latitude: Double, longitude: Double)
//    {
//        self.timestamp = timestamp
//        self.id = id
//        self.latitude = latitude
//        self.longitude = longitude
//    }
    init(
        id: UUID,
        timestamp: Date = Date.now,
        latitude: Double,
        longitude: Double,
        status: Status
    ) {
        self.id = id
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }
    
    enum Status: Int, Codable, Identifiable, CaseIterable {
    case running, paused, completed
        var id: Self {
            self
        }
        var descr: String {
            switch self {
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

@Model
final class Subject {
    var name: String
    var id: UUID
    
    init(name: String, id: UUID)
    {
        self.name = name
        self.id = id
    }
}
