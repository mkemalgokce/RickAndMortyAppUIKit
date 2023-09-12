//
//  Extension+UIColor.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import UIKit

var myBackgroundColor: UIColor? {
    return UIColor(named: "backgroundColor")
}
var favouriteColor: UIColor? {
    return UIColor(named: "favouriteColor")
}
var textColor: UIColor? {
    return UIColor(named: "textColor")
}
var secondTextColor: UIColor? {
    return UIColor(named: "secondTextColor")
}
var cardColor: UIColor? {
    return UIColor(named: "cardColor")
}

extension UIColor {
    /// Value of color in dark mode.
    var dark: UIColor  { resolvedColor(with: .init(userInterfaceStyle: .dark))  }
    /// Value of color in light mode
    var light: UIColor { resolvedColor(with: .init(userInterfaceStyle: .light)) }
}
