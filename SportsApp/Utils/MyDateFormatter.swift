//
//  MyDateFormatter.swift
//  SportsApp
//
//  Created by Israa on 12/05/2024.
//

import Foundation

class MyDateFormatter{
    
    static func getCurrentDate()->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dateFormatter.string(from: Date())
            return currentDate
        }
        static func getDateToPreviousOneYearFromNow()->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date()
            let calendar = Calendar.current
            var dateComponent = DateComponents()
            dateComponent.day = -365
            let pastDate = calendar.date(byAdding: dateComponent, to: currentDate)
            let formattedPastDate = dateFormatter.string(from: pastDate!)
            return formattedPastDate
        }
    
        static func getDateToUpcommingOneYearFromNow()->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date()
            let calendar = Calendar.current
            var dateComponent = DateComponents()
            dateComponent.day = 365
            let futureDate = calendar.date(byAdding: dateComponent, to: currentDate)
            let formattedFutureDate = dateFormatter.string(from: futureDate!)
            return formattedFutureDate
        }
}
