//
//  FavouriteTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 9.04.2023.
//

import UIKit
import SDWebImage
class FavouriteTableViewCell: UITableViewCell {

    var delegate: CellItemDelegate?
    static let identifier: String = "favcell"
    let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = nil
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    let heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = secondTextColor
        return label
        
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = favouriteColor
        contentView.layer.cornerRadius = 8
        self.contentView.addSubview(heroName)
        self.contentView.addSubview(heroImageView)
        
        self.configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func configure(with model : CharacterModel) {
        print(model.name)
        self.heroName.text = model.name
        if let url = URL(string: model.image ?? "") {
            self.heroImageView.sd_setImage(with: url)
        }
       
    }
    
    private func configureConstraints() {
        
        print("Here !")
        NSLayoutConstraint.activate([
            self.heroImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.heroImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0),
            self.heroImageView.heightAnchor.constraint(equalToConstant: 100),
            self.heroImageView.widthAnchor.constraint(equalTo: self.heroImageView.heightAnchor),
            self.heroName.leadingAnchor.constraint(equalTo: self.heroImageView.leadingAnchor, constant: 130),
            self.heroName.centerYAnchor.constraint(equalTo: self.heroImageView.centerYAnchor)
            
            
        ])
    }

}
