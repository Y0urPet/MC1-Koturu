//
//  ModelMyBeverages.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 07/04/24.
//

import Foundation
import SwiftUI

var fileCustomBaverages: String = "customBaverage.json"
var fileDefaultBaverages: String = "defaultBaverage.json"
var filePersonalized: String = "personalizedSetting.json"
var fileDailySleeps: String = "dailySleep.json"
var fileCaffeineConsumption: String = "caffeineConsumption.json"

var customBavearagesTemplate: [CustomBaverage] = loadJsonTemplate(fileCustomBaverages)
var defaultBavearagesTemplate: [DefaultBaverage] = loadJsonTemplate(fileDefaultBaverages)
var personalizedTemplate: Personalized = loadJsonTemplate(filePersonalized)
var dailySleepsTemplate: [DailySleep] = loadJsonTemplate(fileDailySleeps)
var caffeineConsumptionTemplate: [CaffeineConsumption] = loadJsonTemplate(fileCaffeineConsumption)


func getPersonalData() -> Binding<Personalized> {
    var data: Personalized = loadLocalFile(filePersonalized)
    return Binding(
        get: {
            return data
        },
        set: { newValue in
            data = newValue
        }
    )
}

func getDailySleepsData() -> Binding<[DailySleep]> {
    var data: [DailySleep] = loadLocalFile(fileDailySleeps)
    return Binding(
        get: {
            return data
        },
        set: { newValue in
            data = newValue
        }
    )
}

func getDefaultBaveragesData() -> Binding<[DefaultBaverage]> {
    var data: [DefaultBaverage] = loadLocalFile(fileDefaultBaverages)
    return Binding(
        get: {
            return data
        },
        set: { newValue in
            data = newValue
        }
    )
}

func getCustomBaveragesData() -> Binding<[CustomBaverage]> {
    var data: [CustomBaverage] = loadLocalFile(fileCustomBaverages)
    return Binding(
        get: {
            return data
        },
        set: { newValue in
            data = newValue
        }
    )
}

func getCaffeinConsumptionData() -> Binding<[CaffeineConsumption]> {
    var data: [CaffeineConsumption] = loadLocalFile(fileCaffeineConsumption)
    return Binding(
        get: {
            return data
        },
        set: { newValue in
            data = newValue
        }
    )
}

func loadJsonTemplate<T: Decodable>(_ fileName: String) -> T {
    let data: Data

    // Read File from Directory Resources
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("Couldn't find \(fileName) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        // Decode Data
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
}

func loadLocalFile<T: Decodable>(_ fileName: String) -> T {
    // Get Document Directory
    guard let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
        fatalError("Couldn't find \(fileName) in local document.")
    }
    
    do {
        let fileURL = file.appendingPathComponent(fileName)

        let decoder = JSONDecoder()
        let fileData = try Data(contentsOf: fileURL)
        // Decode Data
        return try decoder.decode(T.self, from: fileData)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
}

func save<T: Encodable>(_ data: T, toFile filename: String) {
    do {
        let encoder = JSONEncoder()
        // Encode Data
        let jsonData = try encoder.encode(data)
        
        // Get the URL for the documents directory
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        // Append the filename to the documents directory URL
        let fileURL = documentsURL.appendingPathComponent(filename)
        
        // Write the data to the file
        try jsonData.write(to: fileURL, options: .atomic)
    } catch {
        fatalError("Couldn't save data to \(filename):\n\(error)")
    }
}

func copyFileToDocumentsDirectory(fileName: String) {
    guard let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        return
    }
    
    do {
        if let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
            do {
                if !checkFileExistence(atURL: destinationURL) {
                    try FileManager.default.copyItem(at: bundleURL, to: destinationURL)
                }
            } catch {
                fatalError("Error copying file: \(error)")
            }
        }
    }
}

func deleteFile(fromDocumentWithName filename: String) {
    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        fatalError("Unable to access documents directory.")
    }
    
    do {
        let fileURL = documentsURL.appendingPathComponent(filename)
        
        try FileManager.default.removeItem(at: fileURL)
    } catch {
        fatalError("Error deleting file: \(error)")
    }
}

func checkFileExistence(atURL url: URL) -> Bool {
    return FileManager.default.fileExists(atPath: url.path)
}
