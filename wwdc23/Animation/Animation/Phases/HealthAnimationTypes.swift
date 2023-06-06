//
//  HealthAnimationTypes.swift
//  Animation
//
//  Created by Alex Logan on 06/06/2023.
//

import Foundation
import SwiftUI

enum InnerIcon: CaseIterable {
    case fire, apple, ecg, circles, bed

    var imageName: String {
        switch self {
        case .fire:
            return "flame.fill"
        case .apple:
            return "apple.logo"
        case .ecg:
            return "waveform.path.ecg.rectangle"
        case .circles:
            return "circle.hexagonpath.fill"
        case .bed:
            return "bed.double.fill"
        }
    }

    var color: Color {
        switch self {
        case .fire:
            return .red
        case .apple:
            return .green
        case .ecg:
            return .gray
        case .circles:
            return .orange
        case .bed:
            return .cyan
        }
    }
}

enum OuterIcon: CaseIterable {
    case ear, vials, person, virus, mindfullness, bandaid, medicalChart, heart, lungs, wind

    var imageName: String {
        switch self {
        case .ear:
            return "ear"
        case .vials:
            return "cross.vial"
        case .person:
            return "figure.basketball"
        case .virus:
            return "allergens"
        case .mindfullness:
            return "brain"
        case .bandaid:
            return "bandage"
        case .medicalChart:
            return "list.bullet.clipboard"
        case .heart:
            return "heart.fill"
        case .lungs:
            return "lungs"
        case .wind:
            return "wind"
        }
    }

    var color: Color {
        switch self {
        case .ear:
            return .blue
        case .vials:
            return .gray
        case .person:
            return .purple
        case .virus:
            return .cyan
        case .mindfullness:
            return .teal
        case .bandaid:
            return .blue.opacity(0.5)
        case .medicalChart:
            return .black
        case .heart:
            return .pink
        case .lungs:
            return .blue
        case .wind:
            return .orange
        }
    }
}
