//
//  Color+Extension.swift
//  MyBooks
//
//  Created by Ouimin Lee on 10/9/24.
//

import SwiftUI

extension Color {
    
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor: uiColor)
    }
    
    func toHexString(includeAlpha: Bool = false) -> String? {
        return UIColor(self).toHexString(includeAlpha: includeAlpha)
    }
    
//    func contrastingTextColor() -> Color {
//        // Convert the Color to UIColor to access RGB values
//        let uiColor = UIColor(self)
//        
//        // Extract the red, green, and blue components
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
//        
//        // Calculate the brightness (using the luminance formula)
//        let brightness = (red * 0.299 + green * 0.587 + blue * 0.114)
//        
//        // Return white for dark backgrounds and black for light backgrounds
//        return brightness < 0.5 ? .white : .black
//    }
    
}
