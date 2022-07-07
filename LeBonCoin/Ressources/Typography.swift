//
//  Typography.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//

import Foundation
import UIKit

struct TypoGraphy {
    struct AdList {
        static let title = UIFont.boldSystemFont(ofSize: 14)
        static let category = UIFont.systemFont(ofSize: 11)
        static let price = UIFont.boldSystemFont(ofSize: 10)
        static let creationDate = UIFont.systemFont(ofSize: 9)
        static let urgent = UIFont.systemFont(ofSize: 10)
    }
    struct AdDetails {
        static let title = UIFont.boldSystemFont(ofSize: 16)
        static let category = UIFont.systemFont(ofSize: 11)
        static let price = UIFont.boldSystemFont(ofSize: 12)
        static let creationDate = UIFont.systemFont(ofSize: 10)
        static let description = UIFont.systemFont(ofSize: 12)
        static let descriptionTitle = UIFont.boldSystemFont(ofSize: 14)
        static let urgent = UIFont.systemFont(ofSize: 10)
    }
}
