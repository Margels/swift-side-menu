//
//  loginViewController.swift
//  Bayleaf Store
//
//  Created by Martina on 01/01/22.
//

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameLine: UIView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordLine: UIView!
    @IBOutlet var signinButton: UIButton!
    
    lazy var textFields = [usernameTextField, passwordTextField]
    var placeholders = ["username", "password"]

    override func viewDidLoad() {
        super.viewDidLoad()

        var index = 0
        for textField in textFields {
            textField?.attributedPlaceholder = NSAttributedString(string: placeholders[index],
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField?.delegate = self
            index += 1
        }
        
        signinButton.layer.cornerRadius = signinButton.frame.height / 2
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    func animate(line: UIView) {
        line.alpha = 0.3
        UIView.animate(withDuration: 1) {
            line.alpha = 1
        }
        
        
    }

}

extension loginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField: animate(line: usernameLine)
        case passwordTextField: animate(line: passwordLine)
        default: return
        }
    }
    
}
