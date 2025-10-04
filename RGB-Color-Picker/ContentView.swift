//
//  ContentView.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 03.10.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var colorSliders: [ColorSlider]
    @State private var didEnsureSlider = false
    
    private var colorSlider: ColorSlider? { colorSliders.first }

    var body: some View {
        let r = (colorSlider?.red ?? 0) / 255
        let g = (colorSlider?.green ?? 0) / 255
        let b = (colorSlider?.blue ?? 0) / 255
        
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        let textColor: Color = luminance > 0.6 ? .black : .white
        
        let backgroundColor = colorSlider.map {
            Color(red: $0.red/255, green: $0.green/255, blue: $0.blue/255)
        } ?? Color(.systemBackground)
        
        let rgb: [Double] = [
            r,
            g,
            b
        ]
        
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                if let sliders = colorSlider {
                    @Bindable var slider = sliders
                    
                    Text("R: \(Int(slider.red)), G: \(Int(slider.green)), B: \(Int(slider.blue))")
                    Text(String(format: "#%02X%02X%02X",
                        Int(slider.red),
                        Int(slider.green),
                        Int(slider.blue)))
                    
                    VStack(spacing: 16) {
                        ColorComponentSlider(title: "Red", tint: .red, value: $slider.red)
                        ColorComponentSlider(title: "Green", tint: .green, value: $slider.green)
                        ColorComponentSlider(title: "Blue", tint: .blue, value: $slider.blue)
                    }
                } else {
                    ProgressView()
                }
            }
            .foregroundStyle(textColor)
            .padding(.horizontal)
            .task {
                guard !didEnsureSlider else { return }
                didEnsureSlider = true
                
                if colorSliders.isEmpty {
                    let newSlider = ColorSlider(red: 255, green: 255, blue: 255)
                    modelContext.insert(newSlider)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: rgb)

    }

}

#Preview {
    ContentView()
        .modelContainer(for: [ColorSlider.self], inMemory: true)
}
