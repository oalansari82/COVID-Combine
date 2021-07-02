//
//  String+Extension.swift
//  COVID Combine
//
//  Created by Omar Al-Ansari on 7/2/21.
//

import Foundation

extension String {
    func asAbbreviatedFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: self)
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date ?? Date())
    }
}
