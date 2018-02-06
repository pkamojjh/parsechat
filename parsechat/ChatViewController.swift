//
//  ChatViewController.swift
//  parsechat
//
//  Created by Pallav Kamojjhala on 2/5/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    // properties/fields must be declared here
    // @NSManaged to tell compiler these are dynamic properties
    @NSManaged var message: String?
    @NSManaged var user: String?
    
    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Message"
    }
}



class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    
    var messages: [PFObject]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatViewCell
        let currentMSG = messages?[indexPath.row] as! Message?
        cell.messageCellLabel.text = currentMSG?.message
        cell.userLabel.text = currentMSG?.user
        
        
        return cell
    }
   // var count = 0;
    // let chatMessage = PFObject(className: "Message")

    @IBOutlet weak var tabelView: UITableView!
    @IBAction func sendButton(_ sender: Any) {
       message()
    }
    
    
    @IBOutlet weak var messageField: UITextField!
    
    func message() {
        
        let chatMessage = Message()
        chatMessage.message = messageField.text ?? ""
        chatMessage.user = PFUser.current()?.username
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.getMSGs()
                self.messageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
       
     // tabelView.rowHeight = UITableViewAutomaticDimension

       //tabelView.estimatedRowHeight = 200
    
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onTimer() {
        getMSGs()
            }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMSGs() {
       let query = Message.query()
        query?.addDescendingOrder("createdAt")

        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.messages = posts
                self.tabelView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    
   
    
   
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
