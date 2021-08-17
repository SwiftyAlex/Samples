//
//  SimpleList.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct SimpleList: View {
    let data = SampleData.allSamples
    
    var body: some View {
        List(data, id: \.self, children: \.childElements) { listElement in
            switch listElement.type {
            case .category(let title):
                makeCategoryView(categoryName: title)
            case .sfSymbol(let symbol):
                makeSfSymbolView(symbol: symbol)
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
        HStack {
            Image(systemName: symbol.systemImageName)
                .font(.subheadline)
            Text(symbol.systemImageName)
                .font(.subheadline)
        }
    }
}

struct SimpleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SimpleList()
        }
    }
}
