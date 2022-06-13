//
//  ExampleTagList.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleTagList: View {
    @State var tags : [String] = [
        "SwiftUI", "iOS16", "WWDC22", "iOS Development"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Tags")) {
                    (TagLayout()) {
                        ForEach(tags, id: \.self) { tag in
                            TagView(tag: tag)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Tags")
        }
    }
}

struct TagView: View {
    let tag: String

    var body: some View {
        Text(tag)
            .font(.subheadline.weight(.medium))
            .foregroundColor(.white)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.black.gradient)
            )
    }
}

struct TagGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleTagList()
    }
}
