//
//  Slider.swift
//  RGB-Color-Picker
//
//  Created by Constantine Grinko on 04.10.2025.
//

import Foundation
import SwiftData

@Model
final class ColorSlider {
    var red: Int
    var green: Int
    var blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
}
