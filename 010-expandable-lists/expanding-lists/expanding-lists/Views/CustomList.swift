//
//  CustomList.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct CustomList: View {
    let data = SampleData.allSamples
        
    var body: some View {
        List {
            OutlineGroup(data, id: \.self, children: \.childElements) { listElement in
                switch listElement.type {
                case .category(let title):
                    makeCategoryView(categoryName: title)
                        .tag(listElement)
                case .sfSymbol(let symbol):
                    makeSfSymbolView(symbol: symbol)
                        .tag(listElement)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Custom List")
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

struct CustomList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomList()
        }
    }
}
