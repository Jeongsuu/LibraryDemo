//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Yeojaeng on 2020/11/05.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var models: [Person] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonFollowingTableViewCell.self,
                           forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        configureModels()
    }
    
    private func configureModels() {
        let names = [
            "Kanye", "Dan", "Jeff", "Lee", "James" , "Onil"
        ]
        names.forEach {
            models.append(Person(name: $0))
        }
    }
}

// MARK: - TableView DataSource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell: PersonFollowingTableViewCell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.identifier,
                                                                                     for: indexPath) as? PersonFollowingTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        return cell
    }
}

// Delegate Method
extension ViewController: PersonFollowingTableViewCellDelegate {
    
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        
    }
}
