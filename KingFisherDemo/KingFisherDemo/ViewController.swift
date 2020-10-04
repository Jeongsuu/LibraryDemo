//
//  ViewController.swift
//  KingFisherDemo
//
//  Created by Yeojaeng on 2020/09/22.
//

import UIKit

import Kingfisher
import SnapKit


class ViewController: UIViewController {

    let urlString = "https://i.pinimg.com/originals/c3/35/8b/c3358bb87f18cf8bedac5b5f63710a0f.jpg"

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame.size = CGSize(width: 150, height: 150)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .black
        return iv
    }()

    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Download Image", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.frame.size = CGSize(width: 100, height: 50)
        btn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        button.addTarget(self, action: #selector(fetchImage), for: .touchUpInside)
    }

    private func setupUI() {
        self.view.addSubview(imageView)
        self.view.addSubview(button)

        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-80)
        }

        button.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-50)
        }
    }

    @objc private func fetchImage() {
        let url = URL(string: urlString)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url,
            placeholder: UIImage(systemName: "applelogo"),
            options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.flipFromTop(3))
            ])
    }
}

