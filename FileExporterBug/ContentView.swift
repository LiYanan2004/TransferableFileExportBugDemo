//
//  ContentView.swift
//  FileExporterBug
//
//  Created by LiYanan2004 on 2025/11/5.
//

import SwiftUI
internal import UniformTypeIdentifiers

struct ContentView: View {
    @State var exporting = false
    
    var body: some View {
        VStack {
            Button("Export 'Hello World'") {
                exporting = true
            }
        }
        .padding()
        .fileExporter(
            isPresented: $exporting,
            item: SomeText(string: "Hello World"),
            defaultFilename: "SomeText.txt"
        ) { _ in }
    }
}

struct SomeText {
    var string: String
}

extension SomeText: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .text) { text in
            let intermediateURL = URL.temporaryDirectory.appending(path: "export.txt")
            try! text.string.write(to: intermediateURL, atomically: true, encoding: .utf8)
            print("Exported to \(intermediateURL.path(percentEncoded: false)) from Transferable protocol.")
            return .init(
                intermediateURL,
                allowAccessingOriginalFile: true
            )
        }
    }
}
