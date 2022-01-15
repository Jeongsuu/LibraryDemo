//
//  FruitViewController.swift
//  ReactorKitExample
//
//  Created by Ian on 2022/01/15.
//

import UIKit
import ReactorKit
import RxCocoa

class FruitViewController: UIViewController {

    // MARK: - Properties
    private lazy var appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("사과", for: .normal)
        return button
    }()

    private lazy var bananaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("바나나", for: .normal)
        return button
    }()

    private lazy var grapeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("포도", for: .normal)
        return button
    }()

    private lazy var selectedLabel: UILabel = {
        let label = UILabel()
        label.text = "선택되어진 과일 없음"
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appleButton, bananaButton, grapeButton, selectedLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    private let disposeBag = DisposeBag()
    private let fruitReactor = FruitReactor()

    // MARK: - Binding Properteis


    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind(reactor: fruitReactor)
    }

    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Binding Helpers
    func bind(reactor: FruitReactor) {
        // Input
        appleButton.rx.tap
            .map { FruitReactor.Action.apple }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        bananaButton.rx.tap
            .map { FruitReactor.Action.banana }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        grapeButton.rx.tap
            .map { FruitReactor.Action.grape }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // Output
        reactor.state
            .map { $0.fruitName }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.selectedLabel.text = $0
            })
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                if $0 {
                    self?.selectedLabel.text = "로딩중입니다"
                }
            })
            .disposed(by: disposeBag)
    }
}
