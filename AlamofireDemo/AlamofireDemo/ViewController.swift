//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Yeojaeng on 2020/09/22.
//

import UIKit

import Alamofire
import SnapKit


class ViewController: UIViewController {

    //MARK:- Property
    let urlString = "https://api.androidhive.info/contacts/"
    let tableView = UITableView()
    var dataSource: [Contact] = []

    //MARK:- Method

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupUI()
        registerCell()
        fetchData()
    }

    private func fetchData() {
        AF.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                    self.dataSource = json.contacts
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    private func setupUI() {
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func registerCell() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as! CustomCell
        cell.nameLabel.text = dataSource[indexPath.row].name
        cell.emailLabel.text = dataSource[indexPath.row].email
        cell.genderLabel.text = dataSource[indexPath.row].gender

        return cell
    }
}
