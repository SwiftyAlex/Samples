//
//  _2_DaysApp.swift
//  12 Days
//
//  Created by Alex Logan on 26/12/2022.
//

import SwiftUI

@main
struct _2_DaysApp: App {
    @Environment(\.colorScheme) var systemStyle
    @AppStorage("user_style") var currentStyle: InterfaceStyle = .system

    var colorScheme: ColorScheme {
        switch currentStyle {
        case .system:
            print("System")
            return systemStyle
        case .light:
            print("Light")
            return .light
        case .dark:
            print("Dark")
            return .dark
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
