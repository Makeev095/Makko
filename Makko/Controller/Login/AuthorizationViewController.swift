//
//  AuthorizationViewController.swift
//  Makko
//
//  Created by Макей 😈 on 04.01.2024.
//

import UIKit


class AuthorizationViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    
    var userDefaults = UserDefaults.standard
    
    var checkField = CheckField.shared
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        
        mainView.addGestureRecognizer(tapGest!)
    }

    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func forgorPasswordButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func noAccountButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func AuthorizationButtonClick(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField) {
            
            let authorizationData = LoginField(email: emailField.text!, password: passwordField.text!)
            
            service.authorizationInApp(authorizationData) { [weak self] response in
                switch response {
                case .success:
                    print("next")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                case .noVerified:
                    let alert = self?.alertAction("Ошибка", "Вы не верифицировали свой email. На вашу почту отправлена ссылка для верификации")
                    
                    let verifyButton = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("Ошибка", "Email или пароль не верны")
                    
                    let verifyButton = UIAlertAction(title: "OK", style: .cancel)
                    alert?.addAction(verifyButton)
                    self?.present(alert!, animated: true)
                }
            }
        } else {
            let alert = self.alertAction("Ошибка", "Пожалуйста проверьте правильность введенных данных")
            
            let verifyButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(verifyButton)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }

}
