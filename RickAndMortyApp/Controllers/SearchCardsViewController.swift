//
//  SearchCardsViewController.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 2.04.2023.
//

import UIKit

class SearchCardsViewController: UIViewController {

    
    private var foundCharacters: [CharacterModel] = []
    private var delegate: CellItemDelegate?
    private let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Character name"
        textField.font = .systemFont(ofSize: 22, weight: .bold)
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        return textField
    }()
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FavouriteTableViewCell.self
                       , forCellReuseIdentifier: FavouriteTableViewCell.identifier)
        table.backgroundColor = myBackgroundColor
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.topItem?.titleView = searchField
        
        view.addSubview(homeTable)
        
        homeTable.frame = CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.height)
        homeTable.clipsToBounds = false
        
        homeTable.delegate = self
        homeTable.dataSource = self
        searchField.delegate = self
        delegate = self
        
        
        view.backgroundColor = myBackgroundColor
        
        
        //configureConstraints()
        // Do any additional setup after loading the view.
    }
    
    func searchCard(with name: String) {
        
    }
    
    func configureConstraints() {
        
    }
    
    func updateResults() {
        DispatchQueue.main.async {
            self.homeTable.reloadData()
        }
    }

}


extension SearchCardsViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier, for: indexPath) as? FavouriteTableViewCell else { return UITableViewCell()}
        
        
        cell.configure(with: foundCharacters[indexPath.section])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foundCharacters.count
        
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
        delegate?.showDetails(with: foundCharacters[indexPath.section])
        print("Selected \(indexPath)")
    }
    
}


extension SearchCardsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Did and editing")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Did begin editing")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Text: \(textField.text)")
        APICallerManager.shared.getCharacters(with: textField.text!) { result in
            switch result {
            case .success(let success):
                self.foundCharacters = success
                self.updateResults()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Should begin editing")
        return true
    }
    

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true);
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Here end editing")
        return true
    }
}


extension SearchCardsViewController: CellItemDelegate {
    func showDetails(with model: CharacterModel) {
        print("Show details")
        let vc = DetailsViewController()
        vc.configureVC(model: model)
        self.present(vc, animated: true)
    }
}
