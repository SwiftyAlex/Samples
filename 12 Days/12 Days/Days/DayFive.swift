//
//  DayFive.swift
//  12 Days
//
//  Created by Alex Logan on 28/12/2022.
//

import SwiftUI
import UIKit

struct DayFive: View {
    // AppStorage makes this persist between runs!
    @AppStorage(UserColorSchemeModifier.defaultsKey) var currentStyle: InterfaceStyle = .system

    var body: some View {
        List {
            Section {
                Picker(selection: $currentStyle, content: {
                    ForEach(InterfaceStyle.allCases, id: \.self) { interfaceStyle in
                        Text(interfaceStyle.rawValue)
                    }
                }, label: {
                    Text("Style")
                })
            }
        }
        // Apply this at the root, i.e tab bar or navigation view, and it'll work everywhere!
        .modifier(UserColorSchemeModifier())
    }
}

enum InterfaceStyle: String, CaseIterable {
    case system, light, dark

    var overrideStyle: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct UserColorSchemeModifier: ViewModifier {
    static let defaultsKey = "user_style"

    @AppStorage(Self.defaultsKey) var currentStyle: InterfaceStyle = .system
    @Environment(\.colorScheme) var systemStyle

    func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, currentStyle.overrideStyle ?? systemStyle)
    }
}

struct DayFive_Previews: PreviewProvider {
    static var previews: some View {
        DayFive()
    }
}
