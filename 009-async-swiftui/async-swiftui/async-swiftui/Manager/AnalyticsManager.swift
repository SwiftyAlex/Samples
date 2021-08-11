//
//  AnalyticsManager.swift
//  AnalyticsManager
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation
import Combine

enum AnalyticsScreen {
    case characters, episodes
}

class AnalyticsManager: ObservableObject {
    func screenShown(analyticsScreen: AnalyticsScreen) async {
        await sendAnalytics()
    }
    
    func characterShown(character: Character) async {
        await sendAnalytics()
    }
    
    // Normally, you'd pass some data to this and send it an analytics provider, usually network requests are involved.
    private func sendAnalytics() async {
        // Send stuff
    }
}
