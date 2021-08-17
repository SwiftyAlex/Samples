//
//  FancyCustomList.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct FancyCustomList: View {
    let data = SampleData.allSamples
        
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                ForEach(Album.all, id: \.self) { album in
                    makeAlbumView(album: album)
                }
            }
            Section(header: Text("Symbols")) {
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
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Fancy Custom List")
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
    
    func makeAlbumView(album: Album) -> some View {
        HStack {
            Image(album.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 44, height: 44)
                .cornerRadius(6)
            Text(album.name)
                .font(.subheadline)
        }
    }
    
}

struct FancyCustomList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FancyCustomList()
        }
    }
}
