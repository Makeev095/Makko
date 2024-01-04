//
//  RegistrationViewController.swift
//  Makko
//
//  Created by Макей 😈 on 04.01.2024.
//

import UIKit


class RegistrationViewController: UIViewController {

    var delegate: LoginViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
}
