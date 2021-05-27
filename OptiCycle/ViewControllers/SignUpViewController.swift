//
//  SignUpViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 5/14/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.layer.borderWidth = 2
        usernameTextField.layer.borderColor = UIColor.white.cgColor
        
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.white.cgColor
        
        confirmPasswordTextField.layer.cornerRadius = 5
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.borderColor = UIColor.white.cgColor
        
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.white.cgColor
        
        signInButton.backgroundColor = .clear
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = UIColor.black.cgColor
    }
    
   
    @IBAction func onTapBackground(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        //There is an entry for all boxes
        if usernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != ""{
            if passwordTextField.text == confirmPasswordTextField.text {
                let user = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                user.email = emailTextField.text


                user["firstTimer"] = "true"

                user.signUpInBackground { (success, error) in
                    if success{
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                        
                        
                        user["plastic"] = 0
                        user["metal"] = 0
                        user["paper"] = 0
                        user["totalPosts"] = 0
                        
                        user.saveInBackground()
                        
                        
                        print("\n\n\nNew user created")
                    }
                    else{
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                        print("error: \(error?.localizedDescription)")
                        
                        //The email already is in use
                        if "\(error?.localizedDescription)" == "Optional(\"Account already exists for this email address.\")"
                        {
                            let errorSignUpAlert = UIAlertController(title: "Account already exists for this email address", message: "Please choose a different email.", preferredStyle: .alert) //.actionsheet
                            errorSignUpAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(errorSignUpAlert, animated: true)
                        }
                        //The username already is in use
                        else{
                            let errorSignUpAlert = UIAlertController(title: "Account already exists for this username", message: "Please choose a different username.", preferredStyle: .alert) //.actionsheet
                            errorSignUpAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(errorSignUpAlert, animated: true)
                        }
                    }
                }
            }
            // Passwords don't match
            else{
                let badPasswordNotif = UIAlertController(title: "Passwords Do Not Match", message: "Please make sure passwords match", preferredStyle: .alert) //.actionsheet
                badPasswordNotif.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(badPasswordNotif, animated: true)
            }
        }
        //Entry box is missing information
        else{
            let missingInfoAlert = UIAlertController(title: "Incomplete", message: "Please fill in all requirements.", preferredStyle: .alert) //.actionsheet
            missingInfoAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(missingInfoAlert, animated: true)
        }
    }
    

}
