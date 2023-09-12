//
//  FavouriteCardsViewController.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 2.04.2023.
//

import UIKit

class FavouriteCardsViewController: UIViewController {

    var items: [CharacterModel] = []
    var delegate: CellItemDelegate?
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        table.backgroundColor = myBackgroundColor
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeTable)
        
        homeTable.frame = CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.height)
        homeTable.clipsToBounds = false
        
        view.backgroundColor = myBackgroundColor
        getItems()
        homeTable.delegate = self
        homeTable.dataSource = self
        delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getItems()
        self.homeTable.reloadData()
    }
    
    private func getItems() {
        let decoder = JSONDecoder()
        guard let object = UserDefaults.standard.object(forKey: "model") as? Data else {return}
        do {
            let decoded = try decoder.decode([CharacterModel].self, from: object)
            self.items = decoded
        }catch {
            print("Error on decoding \(error)")
        }
        print("Items count \(items.count)")
    }
    
    func showItems() {
        
    }

}

extension FavouriteCardsViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else { return UITableViewCell()}
        
        
        cell.configure(with: items[indexPath.section])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.showDetails(with: items[indexPath.section])
        print("Selected \(indexPath)")
    }
    
}

extension FavouriteCardsViewController: CellItemDelegate {
    func showDetails(with model: CharacterModel) {
        print("Show details")
        let vc = DetailsViewController()
        vc.configureVC(model: model)
        self.present(vc, animated: true)
    }
    
    
}
