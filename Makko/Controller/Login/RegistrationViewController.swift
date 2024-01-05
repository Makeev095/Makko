//
//  RegistrationViewController.swift
//  Makko
//
//  Created by Макей 😈 on 04.01.2024.
//

import UIKit


class RegistrationViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    
    var service = Service.shared
    
    @IBOutlet weak var mainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var repasswordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        
        mainView.addGestureRecognizer(tapGest!)
        
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationButtonClick(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField)
        {
            if passwordField.text == rePasswordField.text {
                service.createNewUser(LoginField(email: emailField.text!, password: passwordField.text!)) { [weak self] code in
                    switch code.code {
                case 0:
                    print("Произошла ошибка регистрации")
                        
                case 1:
                    print("Успешно зарегистрировались")
                    self?.service.confirmEmail()
                        
                default:
                    print("Неизвестная ошибка")
                    }
                }
            } else {
                print("Пароли не совпадают")
            }
        }
    }
}
