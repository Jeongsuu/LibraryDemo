//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Yeojaeng on 2020/10/04.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

// TodoList

class ViewController: UIViewController {

    //MARK:- Property
    let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }

    let todoRelay = BehaviorRelay<[String]>(value: [])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableViewUI()
        bindTableView()
    }

    /// 네비게이션 바 설정 함수
    private func setupNavigationBar() {
        self.navigationItem.title = "Rx TodoList"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(showAlert))
    }

    /// 테이블뷰 제약사항 설정
    private func setupTableViewUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    /// Relay를 TableView에 바인딩 하는 함수
    private func bindTableView() {
        self.todoRelay
            .bind(to: tableView.rx.items(cellIdentifier: "CellId")) { (idx, task, cell) in
                cell.backgroundColor = .clear
                cell.textLabel?.text = task
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { idx in
                self.tableView.deselectRow(at: idx, animated: true)
            })
            .disposed(by: disposeBag)

    }

    /// alert창을 띄우는 함수
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Add TodoList", message: "write your task", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard let input = alertController.textFields?[0].text else { return }
            if input.count != 0 {
                self.todoRelay.accept(self.todoRelay.value + [input])
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "write yoru task"
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
