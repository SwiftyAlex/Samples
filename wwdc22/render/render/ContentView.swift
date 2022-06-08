//
//  ContentView.swift
//  render
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var imageSize: CGSize?
    @State private var image: UIImage?

    var body: some View {
        VStack(alignment: .center) {
            content
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                self.imageSize = geometry.frame(in: .global).size
                                print(geometry.frame(in: .global).size)
                            }
                            .onChange(of: geometry.frame(in: .global).size) { newValue in
                                self.imageSize = newValue
                                print(newValue)
                            }
                    }
                )
            Divider()
                .padding()
            renderedImage
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(UIColor.systemGroupedBackground)
        )
        .onChange(of: imageSize) { newSize in
            if let newSize {
                let renderer = ImageRenderer(content: content)
                renderer.proposedSize = ProposedViewSize(newSize)
                renderer.scale = UIScreen.main.scale
                self.image = renderer.uiImage
            }
        }
    }

    var content: some View {
        VStack(alignment: .leading) {
            Text("V60 Recipe")
                .font(.subheadline.weight(.semibold))
            BrewElementGrid()
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: 300, maxHeight: 300)
    }

    @ViewBuilder
    var renderedImage: some View {
        if let image = image {
            Image(uiImage: image)
            ShareLink(
                item: Image(uiImage: image),
                preview: SharePreview("Your Recipe", icon: sharePreview)
            )
        } else {
            EmptyView()
        }
    }

    var sharePreview: some Transferable {
        Image(systemName: "text.book.closed.fill")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
