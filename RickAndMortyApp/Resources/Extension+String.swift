//
//  Extension+String.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import Foundation


extension String {

    /// This function capitelizes first letter in strings.
    func capitalizeFirstLetter() -> String {
        let subStrings = self.components(separatedBy: " ")
        var capitelizedString: String = ""
        for item in subStrings {
            capitelizedString += item.prefix(1).uppercased() + item.lowercased().dropFirst() + " "
        }
        capitelizedString.removeLast()
        return capitelizedString
    }
}
