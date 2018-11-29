//
//  extension.swift
//  ToDoList
//
//  Created by NTGMM-02 on 23/07/18.
//  Copyright © 2018 NTGMM-02. All rights reserved.
//

import UIKit
class gradientLayer:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let gradientLayer = layer as? CAGradientLayer{
            gradientLayer.colors = [UIColor.init(red: 100/255, green: 220/255, blue: 255/255, alpha: 1).cgColor,UIColor.init(red: 58/255, green: 123/255, blue: 213/255, alpha: 1).cgColor]

            
            }
        }
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UILabel{
    func getLabel(Text:String,Font:CGFloat,Color:UIColor)->UILabel{
        let label = UILabel()
        label.text = Text
        label.font = .systemFont(ofSize:Font)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color
        return label
    }
}
extension UIButton{
    func getButton(Title:String?,Font:CGFloat?,Color:UIColor?,image:UIImage?,type:UIButtonType?,bgColor:UIColor)->UIButton{
        let button:UIButton?
        if let type = type{
             button = UIButton(type: type)
        }else{
             button = UIButton()
        }
       button?.backgroundColor = bgColor
        button?.translatesAutoresizingMaskIntoConstraints = false
        if let Title = Title{
            button?.setTitle(Title, for: .normal)
            button?.setTitleColor(Color, for: .normal)
        }
        if let image = image{
            button?.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            button?.tintColor = Color
        }
        if let font = Font{
            button?.titleLabel?.font = UIFont.systemFont(ofSize: font)
        }
        return button!
    }
}
extension UITextField{
    func getTextField(placeholder:String,cornerRadius:CGFloat,bgcolor:UIColor)->UITextField{
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = placeholder
        tf.backgroundColor = bgcolor
        tf.textColor = .gray
        tf.layer.cornerRadius = cornerRadius
        tf.setLeftPaddingPoints(10)
        return tf
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}

class ckeckBox:UIButton{
    var delegate:ListController?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




