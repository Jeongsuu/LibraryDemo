//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by Yeojaeng on 2020/11/05.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var offset = 0
    var greenBoxTopConstraint: Constraint?
    
    let backgroundBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let greenBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    let redBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let blueBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Touch It", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 15
        button.addTarget(self,
                         action: #selector(moveDownGreenBox),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(blueBox)
        self.view.addSubview(button)
        setupUI()
    }
    
    private func setupUI() {
        backgroundBox.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        redBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        blueBox.snp.makeConstraints { (make) in
            make.width.equalTo(redBox.snp.width).multipliedBy(2)
            make.height.equalTo(redBox.snp.height).dividedBy(2)
            make.top.equalTo(redBox.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        greenBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            self.greenBoxTopConstraint = make.top.equalTo(blueBox.snp.bottom).offset(30).constraint
        }
        
        button.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(80)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func moveDownGreenBox() {
        offset += 40
        self.greenBoxTopConstraint?.update(offset: offset)
        UIViewPropertyAnimator(duration: 0.4, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
}

#if DEBUG
// opt + cmd + enter : open preview window
// opt + cmd + p : build preview
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        // replace VC want to see
        ViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
    }
}#endif
