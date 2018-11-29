//
//  tableForItem.swift
//  ToDoList
//
//  Created by NTGMM-02 on 24/07/18.
//  Copyright © 2018 NTGMM-02. All rights reserved.
//

import UIKit
class myTableView:UITableView,UITableViewDataSource,UITableViewDelegate{
    var listOfLeftTask:[ToDo] = []
    var changeLabel:ListController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var count = 0,count1 = 0
        listOfLeftTask.forEach { (model) in
            if model.status{
                count += 1
            }else{
                count1 += 1
            }
        }
        if section == 0{
            return count1
        }else{
            return count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label =  UILabel().getLabel(Text: "To Do", Font: 20, Color: .white)
        if section == 1{
            label.text = "Done"
        }
        view.backgroundColor = .clear
        view.addSubview(label)
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),label.heightAnchor.constraint(equalToConstant: 25)])
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath) as! cellForList
   var itemForSelection = [ToDo]()
        listOfLeftTask.forEach { (model) in
            if indexPath.section == 0 && !model.status{
             itemForSelection.append(model)
            }else if indexPath.section == 1 && model.status{
              itemForSelection.append(model)
            }
        }
        
        
        cell.label.text = itemForSelection[indexPath.row].title
        cell.toggled = itemForSelection[indexPath.row].status
        cell.delegate = self
        cell.id = itemForSelection[indexPath.row].id
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        backgroundColor = .clear
        listOfLeftTask = coreDataManager.shared.fetchToDo()
        self.register(cellForList.self, forCellReuseIdentifier: "cellForList")
        self.tableFooterView = UIView()
        self.delegate = self
        self.dataSource = self
        self.allowsMultipleSelectionDuringEditing = true
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       let id = self.listOfLeftTask[indexPath.row].id
        coreDataManager.shared.deleteToDo(id: id)
         self.listOfLeftTask =  coreDataManager.shared.fetchToDo()
        var count = 0
        self.listOfLeftTask.forEach { (something) in
            if something.status != true{
                count += 1
            }
        }
        self.changeLabel?.subtitleLabel.text = "\(count) left"
        self.reloadData()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class cellForList:UITableViewCell,UITextFieldDelegate{
    var delegate:myTableView?
    var id:Double?
    var label = UITextField().getTextField(placeholder: "Text here", cornerRadius: 0, bgcolor: .white)
    var button = UIButton().getButton(Title:nil, Font: nil, Color: nil, image: #imageLiteral(resourceName: "done-icon"), type:nil, bgColor: .white)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          setupViews()
        backgroundColor = .clear
        label.delegate = self
        button.addTarget(self, action: #selector(handleBox), for: .touchUpInside)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        if let id = self.id{
            coreDataManager.shared.deleteToDo(id: id)
            coreDataManager.shared.createToDo(id: id, title: text!, status: toggled!)
            self.delegate?.listOfLeftTask =   coreDataManager.shared.fetchToDo()
            self.delegate?.reloadData()
        }
    }
    @objc func handleBox(){
        if let status = toggled,let delegate = delegate,let id = self.id{
            toggled = !status
            if status == false{
              delegate.changeLabel?.animation1()
            }
            coreDataManager.shared.deleteToDo(id: id)
            coreDataManager.shared.createToDo(id: id, title: label.text!, status: toggled!)
            delegate.changeLabel?.toggleToDo()
        }
    }
    
    var toggled:Bool?{
        didSet{
            if let toggled = toggled{
                UIView.animate(withDuration: 0.2) {
                    if toggled{
                              self.button.setImage(#imageLiteral(resourceName: "done-icon"), for: .normal)
                    }else{
                         self.button.setImage(#imageLiteral(resourceName: "crossImage"), for: .normal)
                 
                    }
                }
            }
        }
    }
    
    
    
    func setupViews(){
        addSubview(label)
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: leftAnchor,constant:4),label.topAnchor.constraint(equalTo: topAnchor,constant:4),label.rightAnchor.constraint(equalTo: rightAnchor,constant:-35),label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)])
        addSubview(button)
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: label.topAnchor,constant:0),button.rightAnchor.constraint(equalTo: rightAnchor,constant:-4),button.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),button.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 2)])
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
