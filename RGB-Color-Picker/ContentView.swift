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
        NavigationSplitView {
            VStack {
                if let sliders = colorSlider {
                    @Bindable var slider = sliders
                    VStack(spacing: 16) {
                        ColorComponentSlider(title: "Red", tint: .red, value: $slider.red)
                        ColorComponentSlider(title: "Green", tint: .green, value: $slider.green)
                        ColorComponentSlider(title: "Blue", tint: .blue, value: $slider.blue)
                    }
                } else {
                    ProgressView()
                }
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            guard !didEnsureSlider else { return }
            didEnsureSlider = true
            
            if colorSliders.isEmpty {
                let newSlider = ColorSlider(red: 0, green: 0, blue: 0)
                modelContext.insert(newSlider)
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [ColorSlider.self], inMemory: true)
}
