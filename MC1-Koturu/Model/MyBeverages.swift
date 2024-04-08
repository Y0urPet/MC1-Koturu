//
//  MyBeverages.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 07/04/24.
//

import Foundation
import SwiftUI

struct DefaultBaverage: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var varians: [Varian]
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

struct Varian: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var caffeine: Int
}

struct CustomBaverage: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
