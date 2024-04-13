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
        deleteFile(fromDocumentWithName: filePersonalized)
        deleteFile(fromDocumentWithName: fileDefaultBaverages)
        deleteFile(fromDocumentWithName: fileCustomBaverages)
        deleteFile(fromDocumentWithName: fileDailySleeps)
        deleteFile(fromDocumentWithName: fileCaffeineConsumption)
        
        // Copy File From Directory Resources Into Local Documents App
        copyFileToDocumentsDirectory(fileName: filePersonalized)
        copyFileToDocumentsDirectory(fileName: fileDailySleeps)
        copyFileToDocumentsDirectory(fileName: fileDefaultBaverages)
        copyFileToDocumentsDirectory(fileName: fileCustomBaverages)
        copyFileToDocumentsDirectory(fileName: fileCaffeineConsumption)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
