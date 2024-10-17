//
//  PieStructure.swift
//  Kassy
//
//  Created by Ouimin Lee on 9/11/24.
//

import Foundation

import SwiftUI

// Shape definition for Pie chart
struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    // To animate the endAngle smoothly
    var animatableData: Double {
        get { endAngle.radians }
        set { endAngle = Angle(radians: newValue) }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()

        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        path.closeSubpath()

        return path
    }
}
