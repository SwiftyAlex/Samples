//
//  ReallyFancyCustomList.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct ReallyFancyCustomList: View {
    let data = SampleData.allSamples
        
    @State var showAlbums: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                DisclosureGroup(
                    isExpanded: $showAlbums,
                    content: {
                        ForEach(Album.all, id: \.self) { album in
                            makeAlbumView(album: album)
                        }
                    },
                    label: { Text("Albums") }
                )
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
        .navigationTitle("Really Fancy Custom List")
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

struct ReallyFancyCustomList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReallyFancyCustomList()
        }
    }
}
