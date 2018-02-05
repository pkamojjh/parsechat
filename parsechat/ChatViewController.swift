//
//  ChatViewController.swift
//  parsechat
//
//  Created by Pallav Kamojjhala on 2/5/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Parse


class ChatViewController: UIViewController {

    @IBAction func sendButton(_ sender: Any) {
       message()
    }
    @IBOutlet weak var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func message() {
        let chatMessage = PFObject(className: "Message")
       // let text = messageField.text
        chatMessage["text"] = messageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageField.text = "" 
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
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
