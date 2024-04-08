//
//  MC1_KoturuApp.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
//

import SwiftUI
import SwiftData

@main
struct MC1_KoturuApp: App {
    init() {
        // Copy File From Directory Resources Into Local Documents App
        copyFileToDocumentsDirectory(fileName: filePersonalized)
        copyFileToDocumentsDirectory(fileName: fileDailySleeps)
        copyFileToDocumentsDirectory(fileName: fileDefaultBaverages)
        copyFileToDocumentsDirectory(fileName: fileCustomBaverages)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
