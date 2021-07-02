//
//  Date+Extension.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import Foundation

extension Date {
    
    // "2021-03-13"
    init(apiDateString: String?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: apiDateString ?? "") ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
}
