//
//  AllPurpose+Utils.swift
//  Social Hub
//
//  Created by Jonathan on 12/27/18.
//  Copyright © 2018 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Floaty

class AllPurpose {
    
    private init() {}
    
    static let shared = AllPurpose()
    
    func showFloaty() {
        UIView.animate(withDuration: 0.3) {
            Floaty.global.button.alpha = 1
        }
    }
    
    func hideFloaty() {
        UIView.animate(withDuration: 0.3) {
            Floaty.global.button.alpha = 0
        }
    }
    
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        self.contentInset.top = topCorrect
    }
    
}
