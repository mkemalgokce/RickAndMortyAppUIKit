//
//  Extension+UIImageView.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 8.04.2023.
//

import Foundation


import UIKit

extension UIImageView {

func makeRounded() {
    let radius = self.frame.width/2.0
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
   }
}
