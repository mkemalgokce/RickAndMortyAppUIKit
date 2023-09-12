//
//  CollectionViewTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 2.04.2023.
//

import UIKit


protocol CellItemDelegate {
    func showDetails(with model: CharacterModel)
}
class CollectionViewTableViewCell: UITableViewCell {

    let defaults = UserDefaults.standard
    
    static let identifier: String = "CollectionViewTableViewCell"
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CardTypeCollectionViewCell.self, forCellWithReuseIdentifier: CardTypeCollectionViewCell.identifier)
        collection.backgroundColor = myBackgroundColor
        return collection
    }()
    
    
    var delegate: CellItemDelegate?
    private var characters: [CharacterModel] = [CharacterModel]()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
                
    }
    
    public func configure(with characters: [CharacterModel]) {
        self.characters = characters
        DispatchQueue.main.async { [weak self] in 
            self?.collectionView.reloadData()
        }
        
    }
    

}

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
    
}

extension CollectionViewTableViewCell: UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardTypeCollectionViewCell.identifier, for: indexPath) as? CardTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        //print(characters[indexPath.row].image)
        cell.backgroundColor = cardColor
        cell.layer.cornerRadius = 10
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.showDetails(with: characters[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        if(indexPath.row == 0) {
            return true
        }else {
            return false
        }
            
    }
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
           // let deleteAction = self.deleteAction(indexPath)
            let deleteAction = UIAction(title: "Add to favourites",image: UIImage(systemName: "star")) { act in
                self.addToFavourites(with: self.characters[indexPath.row])
            }
            
            return UIMenu(children: [deleteAction])
        }
    }
    
    
    private func addToFavourites(with model: CharacterModel) {
        
        var models: [CharacterModel] = []
        if var data = UserDefaults.standard.object(forKey: "model") as? Data {
            let decoder =  JSONDecoder()
            
            do {
                let decodedObject = try decoder.decode([CharacterModel].self, from: data)
                models = decodedObject
            }catch{
                print("Error on decoding \(error)")
            }
            for i in 0..<models.count {
                if model.id == models[i].id {
                    print("Character already in database.")
                    return
                }
            }
        }
        
        models.append(model)
        let encoder = JSONEncoder()
        do {
            let encodedObject = try encoder.encode(models)
            UserDefaults.standard.set(encodedObject, forKey: "model")
        }catch {
            print("Error on decoding \(error)")
        }
        
    }
}
