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
    
    let reference = Firestore.firestore()
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    self?.reference.collection("users").document(userId!).setData(data)
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
    
    func getAllUsers(completion: @escaping ([CurrentUser]) -> ()) {
        
        guard let email = Auth.auth().currentUser?.email else {
            return
        }
        
        var currentUsers = [CurrentUser]()
        
        reference.collection("users").whereField("email", isNotEqualTo: email).getDocuments {snap, error in
            if error == nil {
                if let docs = snap?.documents {
                    for document in docs {
                        let data = document.data()
                        let userId = document.documentID
                        let email = data["email"] as! String
                        currentUsers.append(CurrentUser(id: userId, email: email))
                    }
                }
                completion(currentUsers)
            }
        }
    }
    
    //MARK: -- Messanger
    
    func sendMessage(otherId: String?, conversationId: String?, text: String, completion: @escaping (String) -> ()) {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            if conversationId == nil {
                
                let conversationId = UUID().uuidString
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId!
                ]
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                ]
                
                reference.collection("users").document(uid).collection("conversations").document(conversationId).setData(selfData)
                
                reference.collection("users").document(otherId!).collection("conversations").document(conversationId).setData(otherData)
                
                let message: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                let conversationInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId!
                ]
                
                reference.collection("conversations").document(conversationId).setData(conversationInfo) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    self.reference.collection("conversations").document(conversationId).collection("messages").addDocument(data: message) { error in
                        if error == nil {
                            completion(conversationId)
                        }
                    }
                }
                
            } else {
                let message: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                reference.collection("conversations").document(conversationId!).collection("messages").addDocument(data: message) { error in
                    if error == nil {
                        completion(conversationId!)
                    }
                }
            }
        }
        
    }
    
    func updateConversation() {
        
    }
    
    func getConversationId(otherId: String, completion: @escaping (String) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            reference.collection("users").document(uid).collection("conversations").whereField("otherId", isEqualTo: otherId).getDocuments { snap, error in
                if error != nil {
                    return
                }
                
                if let snap = snap, !snap.documents.isEmpty {
                    let document = snap.documents.first
                    if let conversationId = document?.documentID {
                        completion(conversationId)
                    }
                }
            }
        }
    }
    
    func getAllMessages(chatId: String, completion: @escaping ([Message]) -> ()) {
        
        if let uid = Auth.auth().currentUser?.uid {
            reference.collection("conversations").document(chatId).collection("messages").limit(to: 50).order(by: "date", descending: false).addSnapshotListener { snap, error in
                
                if error != nil {
                    return
                }
                
                if let snap = snap, snap.documents.isEmpty {
                    
                    var messages  = [Message]()
                    var sender = Sender(senderId: uid, displayName: "Me")
                    
                    for document in snap.documents {
                        let data = document.data()
                        let userId = data["sender"] as! String
                        let messageId = document.documentID
                        let date = data["date"] as! Timestamp
                        let sentDate = date.dateValue()
                        let text = data["text"] as! String
                        
                        if userId == uid {
                            sender = Sender(senderId: "1", displayName: "")
                        } else {
                            sender = Sender(senderId: "2", displayName: "")
                        }
                        
                        messages.append(Message(sender: sender, messageId: messageId, sentDate: sentDate, kind: .text(text)))
                    }
                    completion(messages)
                }
            }
        }
    }
    
    func getOneMessage() {
        
    }
}
