//
//  SimpleListWithNavigation.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct SimpleListWithNavigation: View {
    let data = SampleData.allSamples
    
    @State var selection: ListElement?
    
    var body: some View {
        List(data, id: \.self, children: \.childElements, selection: $selection) { listElement in
            switch listElement.type {
            case .category(let title):
                makeCategoryView(categoryName: title)
                    .tag(listElement)
            case .sfSymbol(let symbol):
                makeSfSymbolView(symbol: symbol)
                    .tag(listElement)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Simple List")
    }
    
    func makeCategoryView(categoryName: String) -> some View {
        Text(categoryName)
            .font(.headline)
            .bold()
    }
    
    func makeSfSymbolView(symbol: SFSymbol) -> some View {
        NavigationLink(
            destination: SFSymbolView(symbol:symbol),
            label: {
                HStack {
                    Image(systemName: symbol.systemImageName)
                        .font(.subheadline)
                    Text(symbol.systemImageName)
                        .font(.subheadline)
                }
            })
    }
    
}

struct SimpleListWithNavigation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SimpleListWithNavigation()
        }
    }
}
