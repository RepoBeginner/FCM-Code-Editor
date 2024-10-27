/*
UIText.swift

Copyright (C) 2023, 2024 SparkleChan and SeanIsTethered
Copyright (C) 2024 fridakitten

This file is part of FridaCodeManager.

FridaCodeManager is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

FridaCodeManager is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with FridaCodeManager. If not, see <https://www.gnu.org/licenses/>.
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        CodeEditorView()
    }
}

func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first
}

func saveStringToFile(content: String, fileName: String) {
    if let documentDirectory = getDocumentsDirectory() {
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File saved successfully at: \(fileURL.path)")
        } catch {
            print("Failed to write to file: \(error)")
        }
    }
}

struct CodeEditorView: View {
    @State private var shows: Bool = false
    var body: some View {
        NavigationView {
            List {
                Section() {
                    Button("Open Editor") {
                        shows = true
                    }
                    Button("Save Sample Swift File") {
                        let stringToSave = "import Foundation\n\nprint(\"meow :3\")"
                        let fileName = "sample hello.swift"
                        saveStringToFile(content: stringToSave, fileName: fileName)
                    }
                }
                Section(header: Text("theme")) {
                    Button("Default") {
                        setTheme(0)
                        storeTheme()
                    }
                    Button("Dusk") {
                        setTheme(1)
                        storeTheme()
                    }
                    Button("Midnight") {
                        setTheme(2)
                        storeTheme()
                    }
                }
            }
            .navigationTitle("XCode Editor Mobile")
        }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $shows) {
            NeoEditor(isPresented: $shows, filepath: "\(getDocumentsDirectory()!.path)/sample hello.swift")
        }
    }
}
