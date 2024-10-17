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
    var holeRadiusFraction: CGFloat = 0.075 // Fraction of the total radius for the hole

    // To animate the endAngle smoothly
    var animatableData: Double {
        get { endAngle.radians }
        set { endAngle = Angle(radians: newValue) }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let holeRadius = radius * holeRadiusFraction // Radius for the hole

        var path = Path()

        // Add outer arc
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)

        // Create the hole by adding an inner arc in reverse direction
        path.addArc(center: center,
                    radius: holeRadius,
                    startAngle: endAngle,
                    endAngle: startAngle,
                    clockwise: !clockwise)

        path.closeSubpath()

        return path
    }
}
