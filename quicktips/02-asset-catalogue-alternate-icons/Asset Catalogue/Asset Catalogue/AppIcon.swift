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

    var iconNameThumb: String? {
        switch self {
        case .alternate:
            return "AlternateIconThumb"
        default:
            return "AppIconThumb"
        }
    }
    
    var icon: UIImage {
        return UIImage(named: iconNameThumb ?? iconName ?? "AppIcon") ?? UIImage()
    }
}
