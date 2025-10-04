//
//  ColorComponentSlider.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 04.10.2025.
//
import SwiftUI
import AVFoundation

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
        .sensoryFeedback(.impact(weight: .light, intensity: 0.4), trigger: Int(value))
        .onChange(of: Int(value)) {
            SoundFeedback.shared.playTick()
        }
    }
}
