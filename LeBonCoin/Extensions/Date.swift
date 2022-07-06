//
//  Date.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//

import Foundation

extension Date {
    var toAdDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.locale = .current
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
