//
//  time.swift
//  MC1-Koturu
//
//  Created by Doni Pebruwantoro on 13/04/24.
//

import Foundation

func getDateAndMonth(createdAtString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    if let date = dateFormatter.date(from: createdAtString) {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "id_ID")
        
        outputDateFormatter.setLocalizedDateFormatFromTemplate("d MMMM")
        
        return outputDateFormatter.string(from: date)
    }

    return ""
}

func getDay(createdAtString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    if let day = dateFormatter.date(from: createdAtString) {
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: day)

    }
    
    return ""
}

func timeFormatString() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    return dateFormatter.string(from: date)
}
