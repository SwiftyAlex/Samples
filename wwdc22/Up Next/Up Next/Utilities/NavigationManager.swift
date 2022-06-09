//
//  NavigationManager.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import Foundation
import Combine

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    @Published var requestedEvent: Event?

    func open(event: Event) {
        DispatchQueue.main.async {
            self.requestedEvent = event
        }
    }
}
