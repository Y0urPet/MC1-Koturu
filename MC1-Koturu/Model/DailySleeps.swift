//
//  DailySleeps.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 08/04/24.
//

import Foundation

struct DailySleep: Hashable, Codable, Identifiable {
    var id: Int
    var day: String
    var point: Int
}
