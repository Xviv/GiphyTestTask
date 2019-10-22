//
//  Extensions.swift
//  GiphyTestTask
//
//  Created by Dan on 22.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

///Стандартный инициализатор не очень удобный
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
