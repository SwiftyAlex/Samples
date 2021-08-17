//
//  ListElement.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import Foundation

enum ListElementType: Equatable, Hashable {
    case category(String)
    case sfSymbol(SFSymbol)
}

struct ListElement: Equatable, Hashable {
    let type: ListElementType
    let childElements: [ListElement]?
}

// Sample Data
struct SampleData {
    static let mediaCategory = ListElement(type: .category("Media"), childElements: [
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "play.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "pause.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "stop.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "playpause.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "forward.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "backward.fill")), childElements: nil)
    ])
    static let transportCategory = ListElement(type: .category("Transport"), childElements: [
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "car.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "bolt.car.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "bus.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "tram.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "bicycle")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "airplane")), childElements: nil)
    ])
    static let humanCategory = ListElement(type: .category("Human"), childElements: [
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "person.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "person.2.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "person.3.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "person.crop.square.fill.and.at.rectangle")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "rectangle.stack.person.crop.fill")), childElements: nil),
        ListElement(type: .sfSymbol(SFSymbol(systemImageName: "nose.fill")), childElements: nil)
    ])
    
    static let allSamples = [mediaCategory,transportCategory,humanCategory]
}
