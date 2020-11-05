//
//  ViewController.swift
//  MoyaDemo
//
//  Created by Yeojaeng on 2020/10/21.
//

import UIKit

import Moya
import SnapKit

class ViewController: UIViewController {
    
    fileprivate var users: [User] = [User]()
    
    // make Moya provder
    fileprivate let service = MoyaProvider<APIService>()
    
    // Create tableView.
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    // Create right UIBarButtonItem.
    fileprivate lazy var rightBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(didTapBarbtn))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Moya Demo"
        self.navigationItem.rightBarButtonItem = self.rightBtn
        setupTableView()
        readUsers()
    }
    
    // setup tableView's delegate & datasource & constraints.
    fileprivate func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// act when rightBtn did tapped.
    @objc func didTapBarbtn() {
        let jungsu = User(id: 19940912, name: "Jungsu", userName: "Yeojaeng")
        createUser(name: jungsu.name)
    }
    
    
    // fetch user data with Moya.
    fileprivate func readUsers() {
        service.request(APIService.readUsers) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data)
                    self.users = users
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    /// create user data with Moya.
    /// - Parameter name: user's name
    fileprivate func createUser(name: String) {
        service.request(APIService.createUser(name: name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let newUser = try JSONDecoder().decode(User.self, from: response.data)
                    self.users.insert(newUser, at: 0)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    /// update user data.
    /// - Parameters:
    ///   - id: user's id
    ///   - name: user's name
    ///   - indexPath: user's indexPath
    fileprivate func updateUser(id: Int, name: String, indexPath: IndexPath) {
        service.request(APIService.updateUser(id: id, name: "[Modified]" + name)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let modifiedUser = try JSONDecoder().decode(User.self, from: response.data)
                    self.users[indexPath.row] = modifiedUser
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
    
    
    /// delete selected user.
    /// - Parameters:
    ///   - id: user's id
    ///   - indexPath: user's indexPath
    fileprivate func deleteUser(id: Int, indexPath: IndexPath) {
        service.request(APIService.deleteUser(id: id)) { result in
            switch result {
            case .success(let response):
                print("Delete: \(response)")
                self.users.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

// Datasource Methods.
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        updateUser(id: user.id, name: user.name, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = users[indexPath.row]
        deleteUser(id: user.id, indexPath: indexPath)
    }
}
