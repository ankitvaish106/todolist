//
//  ViewController.swift
//  ToDoList
//
//  Created by NTGMM-02 on 23/07/18.
//  Copyright © 2018 NTGMM-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    view.addSubview(gradientView)
    NSLayoutConstraint.activate([gradientView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),gradientView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)])

        gradientView.addSubview(label)
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),label.topAnchor.constraint(equalTo: gradientView.topAnchor,constant:60),label.heightAnchor.constraint(equalToConstant: 40)])
        gradientView.addSubview(middleLable)
        middleLable.numberOfLines = 2
        middleLable.textAlignment = .center
        NSLayoutConstraint.activate([middleLable.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),middleLable.topAnchor.constraint(equalTo: label.bottomAnchor,constant:60),middleLable.heightAnchor.constraint(equalToConstant: 40)])
        gradientView.addSubview(startWinnigButton)
        NSLayoutConstraint.activate([startWinnigButton.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),startWinnigButton.bottomAnchor.constraint(equalTo:gradientView.bottomAnchor,constant:-60),startWinnigButton.heightAnchor.constraint(equalToConstant: 40),startWinnigButton.widthAnchor.constraint(equalToConstant: 220)])
        let copyRightLabel = UILabel().getLabel(Text: "© 2018| augmatiks.in", Font: 13, Color: .gray)
        view.addSubview(copyRightLabel)
        NSLayoutConstraint.activate([copyRightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),copyRightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-20),middleLable.heightAnchor.constraint(equalToConstant: 20)])
    }
    let label = UILabel().getLabel(Text: "GET IT DONE", Font: 25, Color: .white)
    let middleLable = UILabel().getLabel(Text: "WELCOME GET IT DONE IS BEST WAY\n TO CREATE TODO LIST", Font: 15, Color: .white)
    
    let gradientView:UIView = {
        let view = gradientLayer()
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var startWinnigButton:UIButton = {
        let button = UIButton()
        button.setTitle("START WINNING", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleStartbutton), for: .touchUpInside)
        return button
    }()
    
   @objc func handleStartbutton(){
    UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.startWinnigButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
    }) { (_) in
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.startWinnigButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: {(_) in
            self.present(ListController(), animated: true, completion: nil)
         }
        )
    }
   
    }
    
}

