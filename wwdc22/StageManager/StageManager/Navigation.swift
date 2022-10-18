//
//  Navigation.swift
//  StageManager
//
//  Created by Alex Logan on 12/09/2022.
//

import SwiftUI

struct Navigation: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var selectedScreen: Screen = .basketball
    @State var siderbarSelection: Screen? = .basketball

    var body: some View {
        Group {
            switch horizontalSizeClass {
            case .regular:
                splitView
            default:
                tabView
            }
        }
        .onChange(of: siderbarSelection) { newValue in
            selectedScreen = newValue ?? .basketball
        }
        .onChange(of: selectedScreen) { newValue in
            siderbarSelection = newValue
        }
    }
    
    var splitView: some View {
        NavigationSplitView {
            List(selection: $siderbarSelection) {
                ForEach(Screen.allCases, id: \.self) { screen in
                    Label(
                        screen.displayText,
                        systemImage:  screen.iconName
                    )
                }
            }
        } detail: {
            switch selectedScreen {
            case .basketball:
                pageOne
            case .soccer:
                pageTwo
            case .racing:
                pageThree
            }
        }
    }
    
    var tabView: some View {
        TabView(selection: $selectedScreen) {
            pageOne
            pageTwo
            pageThree
        }
    }
    
    var pageOne: some View {
        Image(systemName: Screen.basketball.iconName)
            .font(.headline)
            .tabItem({
                Label(
                    Screen.basketball.displayText,
                    systemImage:  Screen.basketball.iconName
                )
            })
            .tag(Screen.basketball)
    }
    
    var pageTwo: some View {
        Image(systemName: Screen.soccer.iconName)
            .font(.headline)
            .tabItem({
                Label(
                    Screen.soccer.displayText,
                    systemImage:  Screen.soccer.iconName
                )
            })
            .tag(Screen.soccer)
    }
    
    var pageThree: some View {
        Image(systemName: Screen.racing.iconName)
            .font(.headline)
            .tabItem({
                Label(
                    Screen.racing.displayText,
                    systemImage:  Screen.racing.iconName
                )
            })
            .tag(Screen.racing)
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
