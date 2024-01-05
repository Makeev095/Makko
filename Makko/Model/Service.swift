//
//  Service.swift
//  Makko
//
//  Created by Макей 😈 on 05.01.2024.
//

import UIKit
import Firebase


class Service {
    static var shared = Service()
    
    init() {}
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, error in
            if error == nil {
                if result != nil {
                    // let userId = result?.user.uid
                    completion(ResponseCode(code: 1))
                }
            } else {
                completion(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        })
    }
}
