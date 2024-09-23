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

@Model
final class Log {
    var id: UUID //고유 id
    var timestamp: Date // 시작 시간
    var latitude: Double // 위도
    var longitude: Double // 경도
//    var subject: UUID // 이걸 어케해야하오
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    init(timestamp: Date, id: UUID, latitude: Double, longitude: Double)
    {
        self.timestamp = timestamp
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}
