//
//  UIView.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//

import Foundation
import UIKit

extension UIView {
    func fadeInFadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.alpha = 0
        }, completion: nil)
    }
}
