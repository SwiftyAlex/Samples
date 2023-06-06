//
//  MarkdownExporter.swift
//  Seventeen
//
//  Created by Alex Logan on 06/06/2023.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct MarkdownExporter: View {
    @State var exportFile = false

    var body: some View {
        VStack {
            Button(action: {
                exportFile = true
            }, label: {
                Text("Share")
            })
        }
        .fileExporter(
            isPresented: $exportFile, // Binding for presentation
            document: MarkdownFile(), // Custom `FileDocument`
            contentType: .plainText, // Tell it what UTType you're using
            defaultFilename: "Markdown", // What do you want to call it?
            onCompletion: { saveResult in
                switch saveResult {
                case .success(let url):
                    // Where they stored it
                    print("Saved to \(url)")
                case .failure(let error):
                    // Why it failed
                    print(error.localizedDescription)
                }
            })
        .padding()
    }
}

struct MarkdownFile: FileDocument {
    static var readableContentTypes = [UTType.plainText]
    static var writableContentTypes = [UTType.plainText]

    var text = """
    # Hello <3
    """

    init() { }

    // Credit to Paul Hudson for this!
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

#Preview {
    MarkdownExporter()
}
