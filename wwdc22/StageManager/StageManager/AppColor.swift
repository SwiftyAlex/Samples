//
//  AppColor.swift
//  StageManager
//
//  Created by Alex Logan on 18/10/2022.
//

import Foundation
import SwiftUI

enum AppColor: CaseIterable, Hashable {
    case red, green, blue, yellow, orange, purple, pink, grey, black, brown, white, teal, cyan, mint, indigo

    var color: Color {
        switch self {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .yellow:
            return Color.yellow
        case .orange:
            return Color.orange
        case .purple:
            return Color.purple
        case .pink:
            return Color.pink
        case .grey:
            return Color.gray
        case .black:
            return Color.black
        case .brown:
            return Color.brown
        case .white:
            return Color.white
        case .teal:
            return Color.teal
        case .cyan:
            return Color.cyan
        case .mint:
            return Color.mint
        case .indigo:
            return Color.indigo
        }
    }
}
