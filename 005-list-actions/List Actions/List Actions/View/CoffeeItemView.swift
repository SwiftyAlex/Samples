//
//  CoffeeItemView.swift
//  List Actions
//
//  Created by Alex Logan on 05/07/2021.
//

import SwiftUI

struct CoffeeItemView: View {
    let coffee: Coffee
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: coffee.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            } placeholder: {
                placeholder
            }

            VStack(alignment: .leading) {
                Text(coffee.name)
                    .font(.headline)
            }
            
            Spacer()
        }
    }
    
    var placeholder: some View {
        Color.secondary
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(ProgressView())
            .progressViewStyle(.circular)
    }
}

struct CoffeeItemView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeItemView(coffee: .cortado)
    }
}
