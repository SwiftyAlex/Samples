//
//  MaterialTextItemView.swift
//  Material
//
//  Created by Alex Logan on 05/07/2021.
//

import SwiftUI

struct MaterialTextItemView: View {
    var body: some View {
        ZStack {
            Image("redart")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
            Text("art")
                .font(.headline)
                .foregroundStyle(.ultraThinMaterial)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .shadow(color: .gray.opacity(0.5), radius: 6, x: 0, y: 0)
        .padding()
    }
}

struct MaterialTextItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            MaterialTextItemView()
        }
    }
}
