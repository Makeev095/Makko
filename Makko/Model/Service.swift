//
//  Service.swift
//  Makko
//
//  Created by Макей 😈 on 05.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore


class Service {
    static var shared = Service()
    
    init() {}
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
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
    
    func authorizationInApp(_ data: LoginField, completion: @escaping (AuthorizationResponse) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(.success)
                    } else {
                        self.confirmEmail()
                        completion(.noVerified)
                    }
                }
            }
        }
    }
    
    func getUserStatus() {
        // is isset
        // auth
    }
    
    func getAllUsers(completion: @escaping ([String]) -> ()) {
        Firestore.firestore().collection("users").getDocuments {snap, error in
            if error == nil {
                var emailList = [String]()
                if let docs = snap?.documents {
                    for document in docs {
                        let data = document.data()
                        let email = data["email"] as! String
                        emailList.append(email)
                    }
                }
                completion(emailList)
            }
        }
    }
    
    //MARK: -- Messanger
    
    func sendMessage(otherId: String?, conversationId: String?, message: Message, text: String, completion: @escaping (Bool) -> ()) {
        if conversationId == nil {
            //
        } else {
            let message: [String: Any] = [
                "date": Date(),
                "sender": message.sender.senderId,
                "text": text
            ]
            
            Firestore.firestore().collection("conversations").document(conversationId!).collection("messages").addDocument(data: message) { error in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func updateConversation() {
        
    }
    
    func getConversationId() {
        
    }
    
    func getAllMessages() {
        
    }
    
    func getOneMessage() {
        
    }
}
