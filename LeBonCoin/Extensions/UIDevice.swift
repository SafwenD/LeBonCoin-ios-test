//
//  UIDevice.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 04/07/2022.
//

import Foundation
import UIKit

extension UIDevice {
    static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    static var isIPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
