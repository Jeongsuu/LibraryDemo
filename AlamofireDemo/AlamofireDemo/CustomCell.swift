//
//  CustomCell.swift
//  AlamofireDemo
//
//  Created by Yeojaeng on 2020/09/22.
//

import UIKit

import SnapKit

class CustomCell: UITableViewCell {
    static let identifier: String = "cellIdentifier"

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)

        return label
    }()

    var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)

        return label
    }()

    var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(emailLabel)
        self.contentView.addSubview(genderLabel)

        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-50)
        }

        genderLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(nameLabel.snp.bottom)
        }

        emailLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.top.equalTo(nameLabel.snp.top).offset(30)
            make.bottom.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
}
