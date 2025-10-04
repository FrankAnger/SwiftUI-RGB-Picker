//
//  ContentView.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 03.10.2025.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var didEnsureSlider = false
    @State private var didCopyPulse = false
    @State private var showCopiedLabel = false
    @Query private var colorSliders: [ColorSlider]

    
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
                        .font(.headline)
                    
                    let hexString = String(format: "#%02X%02X%02X",
                        Int(slider.red),
                        Int(slider.green),
                        Int(slider.blue))
                    
                    Text(hexString)
                        .font(.title)
                        .bold()
                        .scaleEffect(didCopyPulse ? 1.12 : 1.0)
                        .animation(.spring(response: 0.22, dampingFraction: 0.6), value: didCopyPulse)
                        .sensoryFeedback(.impact(weight: .medium, intensity: 0.8), trigger: didCopyPulse)
                        .overlay(alignment: .bottom) {
                            if showCopiedLabel {
                                Text("Copied!")
                                    .font(.caption.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(.ultraThinMaterial, in: Capsule())
                                    .offset(y: -60)
                                    .transition(.opacity.combined(with: .scale))
                            }
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = hexString
                            Task {
                                // Pulse up
                                withAnimation(.spring(response: 0.22, dampingFraction: 0.6)) {
                                    didCopyPulse = true
                                    showCopiedLabel = true
                                }
                                // Let the pulse complete
                                try? await Task.sleep(nanoseconds: 180_000_000) // ~0.18s
                                withAnimation(.spring(response: 0.22, dampingFraction: 0.7)) {
                                    didCopyPulse = false
                                }
                                // Keep the label a bit longer, then fade it out
                                try? await Task.sleep(nanoseconds: 720_000_000) // additional ~0.72s (total ~0.9s)
                                withAnimation(.easeOut(duration: 0.3)) {
                                    showCopiedLabel = false
                                }
                            }
                        }
                    
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
