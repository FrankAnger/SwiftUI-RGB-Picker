//
//  RGB_Color_PickerApp.swift
//  RGB-Color-Picker
//
//  Created by FrankAnger on 03.10.2025.
//

import SwiftUI
import SwiftData

@main
struct RGB_Color_PickerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ColorSlider.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

