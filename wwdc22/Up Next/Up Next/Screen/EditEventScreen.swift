//
//  EditEventScreen.swift
//  Up Next
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI
import PhotosUI

struct EditEventScreen: View {
    var existingEvent: Event?
    var onSave: () -> ()

    private enum Field: Int, Hashable { case name, date }

    @EnvironmentObject var storage: Storage
    @FocusState private var focusedField: Field?

    @State var showError: Bool = false
    @State var showPicker: Bool = false
    @State var name: String = ""
    @State var date: Date = Date()
    @State var image: UIImage?


    init(existingEvent: Event?, onSave: @escaping () -> ()) {
        self.onSave = onSave
        if let existingEvent {
            self.existingEvent = existingEvent
        }
    }

    var body: some View {
        List {
            Section { } // Empty section for some nice padding
            Section("About your event") {
                TextField("Name", text: $name)
                    .focused($focusedField, equals: .name)
                    .textInputAutocapitalization(.words)
                    .autocapitalization(.words)
                DatePicker("Date", selection: $date)
                    .focused($focusedField, equals: .date)
            }
            Section("The picture") {
                Button(action: {
                    showPicker = true
                }, label: {
                    Text(image == nil ? "Add image" : "Change image")
                })
            }
            if image != nil {
                Section {
                    imageView
                        .listRowInsets(EdgeInsets())
                }
            }
        }
        .navigationTitle("Your event")
        .navigationBarItems(trailing: saveButton)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .name
            }
            if let existingEvent {
                self.name = existingEvent.name
                self.date = existingEvent.date
                self.image = UIImage(data: existingEvent.imageData)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: { focusedField = nil }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .aspectRatio(1.66, contentMode: .fill)
                                    .foregroundStyle(Color.accentColor.gradient)
                            )
                    })
                }
                .padding()
            }
        }
        .sheet(isPresented: $showPicker) {
            PhotoPicker(image: $image)
        }
    }

    var saveButton: some View {
        Button {
            save()
        } label: {
            Text("Save")
                .font(.subheadline.weight(.medium))
        }
        .disabled(name.isEmpty || image == nil)
    }

    @ViewBuilder
    var imageView: some View {
        if let uiImage = self.image {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .transition(.opacity.combined(with: .scale(scale: 0.99)).animation(.easeInOut))
        } else {
            EmptyView()
        }
    }


    func save() {
        Task {
            if let existingEvent = existingEvent {
                let revisedEvent = Event(id: existingEvent.id, name: name, date: date, imageData: makeImageData() ?? existingEvent.imageData)
                await storage.edit(event: revisedEvent)
            } else if let imageData = makeImageData() {
                let newEvent = Event(
                    name: name, date: date, imageData: imageData
                )
                await storage.store(event: newEvent)
            } else {
                showError = true
            }
            onSave()
        }
    }

    func makeImageData() -> Data? {
        guard let image = image else {
            return nil
        }
        return image.scalePreservingAspectRatio(targetSize: CGSize(width: 300, height: 300)).jpegData(compressionQuality: 1.0)
    }
}

struct EditEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditEventScreen(existingEvent: .newYork, onSave: { })
    }
}

// https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let scaleFactor = min(widthRatio, heightRatio)

        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }

        return scaledImage
    }
}
