//
//  ListController.swift
//  ToDoList
//
//  Created by NTGMM-02 on 23/07/18.
//  Copyright © 2018 NTGMM-02. All rights reserved.
//

import UIKit
class ListController:UIViewController,UITextFieldDelegate{
    var keyboardHeight:CGFloat = 271
    let topView = gradientLayer()
    let titleLable = UILabel().getLabel(Text: "Stuff to get done", Font: 15, Color: .white)
    var subtitleLabel = UILabel().getLabel(Text: "4 left", Font: 20, Color: .white)
    let addButton = UIButton().getButton(Title: nil, Font: nil, Color: .black, image: #imageLiteral(resourceName: "addButton"),type: .system, bgColor: .white)
    let middleView = gradientLayer()
    let bottomView = gradientLayer()
    let cancelButton = UIButton().getButton(Title: "Cancel", Font: 15, Color: .gray, image: nil, type: .system, bgColor: .white)
    let bottomAddButton = UIButton().getButton(Title: "Add", Font: 15, Color: .gray, image: nil, type: .system, bgColor: .white)
    let textField = UITextField().getTextField(placeholder: "Text Here", cornerRadius: 8, bgcolor: .white)
    let tableView = myTableView()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sometaskForLableLoad()
        bottomView.isHidden = true
        textField.autocorrectionType = .no
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        view.backgroundColor = .white
        setupViews()
    }
   func sometaskForLableLoad(){
    var count = 0
    self.tableView.listOfLeftTask.forEach({ (model) in
        if model.status != true{
            count += 1
        }
    })
    self.subtitleLabel.text = "\(count) left"
    tableView.changeLabel = self
    }
    @objc func handleAdd(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.bottomView.isHidden = false
        }, completion: nil)
        
    }
    
    var bottomViewHeight:NSLayoutConstraint?
    func setupViews(){
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topView.leftAnchor.constraint(equalTo: view.leftAnchor),topView.topAnchor.constraint(equalTo: view.topAnchor),topView.rightAnchor.constraint(equalTo: view.rightAnchor),topView.heightAnchor.constraint(equalToConstant: 120)])
        topView.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([subtitleLabel.leftAnchor.constraint(equalTo: topView.leftAnchor,constant:20),subtitleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor,constant:-10),subtitleLabel.heightAnchor.constraint(equalToConstant: 20)])
        topView.addSubview(titleLable)
        NSLayoutConstraint.activate([titleLable.leftAnchor.constraint(equalTo: subtitleLabel.leftAnchor,constant:0),titleLable.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor,constant:-5),titleLable.heightAnchor.constraint(equalToConstant: 15)])
        topView.addSubview(addButton)
        addButton.layer.cornerRadius = 14
        NSLayoutConstraint.activate([addButton.rightAnchor.constraint(equalTo: topView.rightAnchor,constant:-10),addButton.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor,constant:0),addButton.heightAnchor.constraint(equalToConstant: 30),addButton.widthAnchor.constraint(equalToConstant: 30)])
        
        view.addSubview(middleView)
        middleView.layer.cornerRadius = 14
        middleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([middleView.leftAnchor.constraint(equalTo: view.leftAnchor,constant:20),middleView.topAnchor.constraint(equalTo: topView.bottomAnchor,constant:20),middleView.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-20),middleView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -240)])
        
        middleView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leftAnchor.constraint(equalTo: middleView.leftAnchor,constant:8),tableView.topAnchor.constraint(equalTo: middleView.topAnchor,constant:8),tableView.rightAnchor.constraint(equalTo: middleView.rightAnchor,constant:-8),tableView.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -8)])
        
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 15
        NSLayoutConstraint.activate([bottomView.widthAnchor.constraint(equalTo: view.widthAnchor,constant:-40),bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor),bottomView.heightAnchor.constraint(equalToConstant: 80)])
        self.bottomViewHeight = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.bottomViewHeight?.isActive = true
        bottomView.addSubview(cancelButton)
        NSLayoutConstraint.activate([cancelButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor,constant:10),cancelButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant:10),cancelButton.heightAnchor.constraint(equalToConstant: 20)])
        bottomView.addSubview(bottomAddButton)
        NSLayoutConstraint.activate([bottomAddButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor,constant:-10),bottomAddButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant:10),bottomAddButton.heightAnchor.constraint(equalToConstant: 20)])
        bottomView.addSubview(textField)
        textField.delegate = self
        NSLayoutConstraint.activate([textField.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),textField.topAnchor.constraint(equalTo: bottomAddButton.bottomAnchor,constant:5),textField.widthAnchor.constraint(equalTo: bottomView.widthAnchor,constant:-40),textField.heightAnchor.constraint(equalToConstant: 25)])
        targets()
        
    }
   func targets(){
    cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
    bottomAddButton.addTarget(self, action: #selector(handleAddToList), for: .touchUpInside)
    }
    
    @objc func handleCancelButton(){
        self.textField.text = nil
        self.textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.bottomView.isHidden = true
        }, completion: nil)
        
    }
    @objc func handleAddToList(){
        if let text = textField.text{
            if let incrementalId = self.tableView.listOfLeftTask.last?.id {
                coreDataManager.shared.createToDo(id: incrementalId+1, title: text, status: false)
           }else{
                  coreDataManager.shared.createToDo(id: 1, title: text, status: false)
            }
        }
        self.tableView.listOfLeftTask = coreDataManager.shared.fetchToDo()
        self.tableView.reloadData()
        handleCancelButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
      @objc func handleKeyboardWillShow(_ notification: Notification) {
            let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        self.bottomViewHeight?.constant = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!+0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        }
    
      @objc  func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            self.bottomViewHeight?.constant = 0
        UIView.animate(withDuration: keyboardDuration!+0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
         
             self.view.layoutIfNeeded()
        }, completion: nil)        }
    
    func toggleToDo(){
        self.tableView.listOfLeftTask = coreDataManager.shared.fetchToDo()
        self.tableView.reloadData()
        var count = 0
         self.tableView.listOfLeftTask.forEach { (listItem) in
           if listItem.status != true{
                count += 1
            }
        }
        self.subtitleLabel.text = "\(count) left"
    }
    func animation1() {
        (0...10).forEach { (_) in
            animation()
        }
    }
    
    func animation(){
        let image:UIImage = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up"):#imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        let dimention = 20+drand48()*10
        imageView.frame = CGRect(x: -100, y: -100, width: dimention, height: dimention)
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        let duration = 2 + drand48() * 3
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        imageView.layer.add(animation, forKey: nil)
        middleView.addSubview(imageView)
    }
    
    func customPath()->UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 200))
        let endpoint = CGPoint(x: 400, y: 200)
        let randomYShift = 200 + drand48()*300
        let cp1 = CGPoint(x: 100, y: 100-randomYShift)
        let cp2 = CGPoint(x: 200, y: 300+randomYShift)
        path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
}











