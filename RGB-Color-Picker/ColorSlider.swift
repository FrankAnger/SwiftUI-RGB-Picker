//
//  Slider.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 04.10.2025.
//

import Foundation
import SwiftData

@Model
final class ColorSlider {
    var red: Double
    var green: Double
    var blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
}
