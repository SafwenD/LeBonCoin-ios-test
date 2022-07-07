//
//  String.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 04/07/2022.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    func attributedText(color: UIColor?, font: UIFont) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color ?? .black]
        let attText = NSMutableAttributedString(string: self)
        attText.addAttributes(attributes, range: NSRange(location: 0, length: self.count))
        return attText
    }
}
