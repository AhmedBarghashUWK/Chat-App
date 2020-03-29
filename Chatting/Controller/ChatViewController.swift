//
//  ChatViewController.swift
//  Chatting
//
//  Created by Ahmed barghash on 2/25/20.
//  Copyright © 2020 Ahmed barghash. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    var messageArray : [Message] = [Message]()
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.delegate = self
        
        chatTableView.tableFooterView = UIView()
        chatTableView.tableHeaderView = UIView()
        chatTableView.separatorStyle = .none
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        //TODO: Register MessageCell Nib
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        //TODO: Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        chatTableView.addGestureRecognizer(tapGesture)
        
//        configureTableView()
        retrieveMessages()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    // when textField begin editing
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    // when textField end editing
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }

    @IBAction func onClickSend(_ sender: Any) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextField.text!]
        messageDB.childByAutoId().setValue(messageDictionary){
            (error,reference) in
            if error != nil{
                print(error!)
            }else{
                print("Message saved successfully....")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
        
    }
    
    //TODO: create retrieve messages method:
    func retrieveMessages(){
        
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            self.chatTableView.reloadData()
            
        }
        
    }
    
    @IBAction func onClickLogOut(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error during Loging out....!")
        }
    }
}

extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomMessageCell
       
        cell.messageLbl.text = messageArray[indexPath.row].messageBody
        cell.senderNameLbl.text = messageArray[indexPath.row].sender
        cell.userImageView.image = UIImage(named: "user")
        
        if cell.senderNameLbl.text == Auth.auth().currentUser?.email {
            cell.userImageView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.messageBackground.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }else{
            cell.userImageView.backgroundColor = #colorLiteral(red: 0.4331298283, green: 0.6312291029, blue: 0.9995340705, alpha: 1)
            cell.messageBackground.backgroundColor = #colorLiteral(red: 0.1423370973, green: 0.9995340705, blue: 0.865865761, alpha: 1)
        }
        
        return cell
    }
    
 /*   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }*/
    
//    func configureTableView(){
//
//        chatTableView.rowHeight = UITableView.automaticDimension
//        chatTableView.estimatedRowHeight = 120.0
//
//    }
    
}
