//
//  ColorComponentSlider.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 04.10.2025.
//
import SwiftUI

struct ColorComponentSlider: View {
    let title: String
    let tint: Color
    @Binding var value: Double

    var body: some View {
        Slider(value: $value, in: 0...255, step: 1) {
            Text(title)
        } minimumValueLabel: {
            Text("0")
        } maximumValueLabel: {
            Text("255")
        }
        .tint(tint)
    }
}
