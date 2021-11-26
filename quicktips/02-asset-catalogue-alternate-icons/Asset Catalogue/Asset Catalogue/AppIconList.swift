//
//  AppIconList.swift
//  Asset Catalogue
//
//  Created by Alex Logan on 26/11/2021.
//

import SwiftUI

struct AppIconList: View {
    var body: some View {
        List {
            Section(header: Text("Standard Icons")) {
                ForEach(AppIcon.allCases,id: \.self) { icon in
                    makeIconRow(icon: icon)
                }
            }
        }
        .navigationTitle(Text("Icons"))
    }
    
    func makeIconRow(icon: AppIcon) -> some View {
        Button(action: {
            UIApplication.shared.setAlternateIconName(icon.iconName, completionHandler: { (err) in
                if err != nil {
                    
                }
            })
        }, label: {
            HStack(alignment: .center) {
                Image(uiImage: icon.icon)
                    .resizable()
                    .frame(width: 66, height: 66, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text(icon.rawValue)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
        })
    }
}

struct AppIconList_Previews: PreviewProvider {
    static var previews: some View {
        AppIconList()
    }
}
