//
//  MaterialItemView.swift
//  Material
//
//  Created by Alex Logan on 05/07/2021.
//  Donuts by Heather Ford on Unsplash.
//  https://unsplash.com/@the_modern_life_mrs
 
import SwiftUI

struct MaterialItemView: View {
    var body: some View {
        ZStack {
            Image("donuts")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .overlay(.ultraThinMaterial)
            Text("Donuts")
                .font(.headline)
                .foregroundStyle(.primary)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .shadow(color: .gray.opacity(0.5), radius: 6, x: 0, y: 0)
        .padding()
    }
}

struct MaterialItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            MaterialItemView()
        }
    }
}
