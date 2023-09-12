//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 2.04.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    let titleArray: [String] = ["Alive Characters", "Dead Characters", "Unknown Characters"]
    
    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.backgroundColor = myBackgroundColor
        table.separatorStyle = .none
        return table
    }()
    
    private func configureNavBar() {
        let image = UIImage(named: "heroLogo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = textColor
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myBackgroundColor
        
        view.addSubview(homeTable)
        
        homeTable.frame = CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.height)
        homeTable.clipsToBounds = false

        
        homeTable.delegate = self
        homeTable.dataSource = self
        
        
        configureNavBar()
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2.1))
        homeTable.tableHeaderView = headerView
        homeTable.tableHeaderView?.clipsToBounds = false
    }
    
    func openDetailView() {
        
    }
    // Scroll asagi indiginde ustteki navigation barin uste sabit kalmasini engeller.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
    }
    

}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Index Path \(indexPath.section)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        
        if(indexPath.section == 0) {
            APICallerManager.shared.getCharactersWithStatus(.alive) { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }else if (indexPath.section == 1) {

            APICallerManager.shared.getCharactersWithStatus(.dead) { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }else {
            APICallerManager.shared.getCharactersWithStatus(.unknown) { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = secondTextColor
        header.textLabel?.text = titleArray[section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleArray[section]
    }
    
}


extension HomeViewController: CellItemDelegate {
    func showDetails(with model: CharacterModel) {
        let vc = DetailsViewController()
        vc.configureVC(model: model)
        self.present(vc, animated: true)
    }
}
