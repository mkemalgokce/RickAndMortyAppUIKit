//
//  HeroHeaderUIView.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "heroPoster")
        return imageView
    }()
    
//    private func addGradient() {
//        let gradientLayer = CAGradientLayer()
//
//        gradientLayer.colors = [
//            UIColor.clear.cgColor,
//            myBackgroundColor!.cgColor
//        ]
//        gradientLayer.frame = self.bounds
//        layer.addSublayer(gradientLayer)
//    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        
        self.addSubview(heroImageView)
//        self.addGradient()
        
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.heroImageView.frame = self.bounds

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
