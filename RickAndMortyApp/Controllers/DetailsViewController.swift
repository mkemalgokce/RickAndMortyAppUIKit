//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 8.04.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    let heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textColor = secondTextColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = myBackgroundColor
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(heroImage)
        self.view.addSubview(detailsLabel)
        
        configureConstraints()
        // Do any additional setup after loading the view.
    }
    
    func getDetailString(model: CharacterModel)-> String {
    
        return """
            Name: \(model.name?.capitalizeFirstLetter() ?? "Unknown")
            Status: \(model.status?.rawValue.capitalizeFirstLetter() ?? "Unknown")
            Species: \(model.species?.rawValue.capitalizeFirstLetter() ?? "Unknown")
            Type: \(model.species?.rawValue ?? "Unknown")
            Gender: \(model.gender?.rawValue.capitalizeFirstLetter() ?? "Unknown")
            Origin: \(model.origin?.name?.capitalizeFirstLetter() ?? "Unknown")
            Location: \(model.location?.name?.capitalizeFirstLetter() ?? "Unknown")
            """
    }
    
    func configureVC(model: CharacterModel) {
        print("VC configured")
        self.titleLabel.text = model.name?.uppercased()
        self.detailsLabel.text = getDetailString(model: model)
        if let imageString = model.image {
            if let url = URL(string: imageString) {
                self.heroImage.sd_setImage(with: url)
            }
        }
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            heroImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            heroImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            heroImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3),
            heroImage.widthAnchor.constraint(equalTo: heroImage.heightAnchor),
            detailsLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: heroImage.leadingAnchor),
            detailsLabel.widthAnchor.constraint(equalTo: heroImage.widthAnchor)
            
        ])
        
    }
    
    
}
