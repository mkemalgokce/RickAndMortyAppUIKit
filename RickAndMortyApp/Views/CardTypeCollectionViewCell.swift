//
//  CardTypeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import UIKit
import SDWebImage

class CardTypeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CardTypeCollectionViewCell"
    private var characterModel: CharacterModel?
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = nil
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        
    }
    override func layoutSubviews() {
        backgroundImageView.frame = CGRect(x: 5, y: 5, width: bounds.width - 10, height: bounds.height - 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CharacterModel) {
        if let imageString = model.image {
            guard let url = URL(string: imageString) else {return}
            
            backgroundImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "heroLogo"))
        }
        self.characterModel = model
    }
    
//    private func addGradient() {
//        let deadLayer = CALayer()
//
//        deadLayer.frame = self.bounds
//        deadLayer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
//        layer.addSublayer(deadLayer)
//    }
    

}

