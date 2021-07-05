//
//  Data.swift
//  List Actions
//
//  Created by Alex Logan on 05/07/2021.
//

import Foundation

struct Coffee: Hashable {
    let name: String
    let imageUrl: URL?
    
    static let all: [Coffee] = [
        .cortado, .flatWhite, .mocha, .latte, .icedLatte, .hotChocolate
    ]
    
    // These images are all provided by unsplash.
    static let cortado = Coffee(name: "Cortado", imageUrl: URL(string: "https://images.unsplash.com/photo-1515283709260-ee29296f1534?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=573&q=80"))
    static let flatWhite = Coffee(name: "Flat White", imageUrl: URL(string: "https://images.unsplash.com/photo-1517236837508-2b3fca41f2f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1268&q=80"))
    static let mocha = Coffee(name: "Mocha", imageUrl: URL(string: "https://images.unsplash.com/photo-1521813475821-5e3f5bc3c7a6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1575&q=80"))
    static let latte = Coffee(name: "Latte", imageUrl: URL(string: "https://images.unsplash.com/photo-1582202737800-8ab9a8cc6e6a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1268&q=80"))
    static let icedLatte = Coffee(name: "Iced Latte", imageUrl: URL(string: "https://images.unsplash.com/photo-1558122104-355edad709f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1600&q=80"))
    static let hotChocolate = Coffee(name: "Hot Chocolate", imageUrl: URL(string:"https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1268&q=80"))
}
