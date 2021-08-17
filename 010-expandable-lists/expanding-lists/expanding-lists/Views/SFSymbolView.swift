//
//  SFSymbolView.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct SFSymbolView: View {
    let symbol: SFSymbol
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: symbol.systemImageName)
                .resizable()
                .frame(maxHeight: 128)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
            Text(symbol.systemImageName)
                .font(.title)
                .bold()
            Spacer()
        }
    }
}

struct SFSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolView(symbol: SFSymbol(systemImageName: "airplane"))
    }
}
