//
//  CaffeinConsumption.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 09/04/24.
//

import Foundation

struct CaffeineConsumption: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var caffeine: Int
    var createdAt: String
}
