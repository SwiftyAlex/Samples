//
//  NavigationManager.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import Foundation

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    @Published var requestedCoffee: Coffee?
    @Published var requestedMenu: Bool = false

    func open(coffee: Coffee) {
        DispatchQueue.main.async {
            self.requestedCoffee = coffee
        }
    }
    func openMenu() {
        DispatchQueue.main.async {
            self.requestedMenu = true
        }
    }
}
