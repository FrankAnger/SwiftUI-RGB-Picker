//
//  Slider.swift
//  RGB-Color-Picker
//
//  Created by Constantine Grinko on 04.10.2025.
//

import Foundation
import SwiftData

@Model
final class Slider {
    var Red: any Numeric
    var Green: any Numeric
    var Blue: any Numeric
    
    init(Red: any Numeric, Green: any Numeric, Blue: any Numeric) {
        self.Red = Red
        self.Green = Green
        self.Blue = Blue
    }
    
}
