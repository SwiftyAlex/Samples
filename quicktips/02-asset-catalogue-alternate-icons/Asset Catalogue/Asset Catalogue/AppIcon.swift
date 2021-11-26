//
//  AppIcon.swift
//  Asset Catalogue
//
//  Created by Alex Logan on 26/11/2021.
//

import Foundation
import UIKit

enum AppIcon: String, CaseIterable {
    case standard = "Default"
    case alternate = "Alternate"
    
    var iconName: String? {
        switch self {
        case .alternate:
            return "AlternateIcon"
        default:
            return nil
        }
    }
    
    var icon: UIImage {
        return UIImage(named: iconName ?? "AppIcon") ?? UIImage()
    }
}
