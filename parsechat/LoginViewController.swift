//
//  LoginViewController.swift
//  parsechat
//
//  Created by Pallav Kamojjhala on 1/31/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginUser() {
        
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if username == "" || password == "" {
                let alert = UIAlertController(title: "Failed!" , message: "No password or username", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            if let error = error {
                let alert = UIAlertController(title: "Failed!" , message: "Failed to Login", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
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
