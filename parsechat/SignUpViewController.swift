//
//  SignUpViewController.swift
//  parsechat
//
//  Created by Pallav Kamojjhala on 2/5/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {

    @IBAction func signUp(_ sender: Any) {
        registerUser()
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func registerUser() {
        
        if Username.text == "" || password.text == "" || confirmPassword.text == "" || email.text == "" {
            let alert = UIAlertController(title: "Failed!" , message: "Check for empty field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if password.text != confirmPassword.text {
            let alert = UIAlertController(title: "Failed!" , message: "Check for matching passwords", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = Username.text
        newUser.email = email.text
        newUser.password = password.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alert = UIAlertController(title: "Failed!" , message: "Failed to SignUp", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
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
