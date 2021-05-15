//
//  ChangeDataViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 5/14/21.
//

import UIKit
import Parse

class ChangeDataViewController: UIViewController {

    @IBOutlet weak var oldDataLabel: UILabel!
    @IBOutlet weak var newDataLabel: UILabel!
    @IBOutlet weak var oldDataTextField: UITextField!
    @IBOutlet weak var newDataTextField: UITextField!
    @IBOutlet weak var confirmNewDataLabel: UILabel!
    @IBOutlet weak var confirmNewDataTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if objectsArray[mySection].sectionObjects[myObject] == "Change Username"{
            oldDataLabel.text = "Old Username"
            newDataLabel.text = "New Username"
            confirmNewDataLabel.text = "Confirm New Username"
            oldDataTextField.placeholder = "Enter Old Username"
            newDataTextField.placeholder = "Enter New Username"
            confirmNewDataTextField.placeholder = "Re-Enter New Username"
            self.title = "Change Username"
        }
        else if objectsArray[mySection].sectionObjects[myObject] == "Change Email"{
            oldDataLabel.text = "Old Email"
            newDataLabel.text = "New Email"
            confirmNewDataLabel.text = "Confirm New Email"
            oldDataTextField.placeholder = "Enter Old Email"
            newDataTextField.placeholder = "Enter New Email"
            confirmNewDataTextField.placeholder = "Re-Enter New Email"
            self.title = "Change Email"
        }
        else if objectsArray[mySection].sectionObjects[myObject] == "Change Password"{
            oldDataLabel.text = "Old Password"
            newDataLabel.text = "New Password"
            confirmNewDataLabel.text = "Confirm New Password"
            oldDataTextField.placeholder = "Enter Old Passowrd"
            newDataTextField.placeholder = "Enter New Passowrd"
            confirmNewDataTextField.placeholder = "Re-Enter New Password"
            self.title = "Change Password"
        }
        
        oldDataTextField.layer.cornerRadius = 5
        oldDataTextField.layer.borderWidth = 2
        oldDataTextField.layer.borderColor = UIColor.white.cgColor
        
        newDataTextField.layer.cornerRadius = 5
        newDataTextField.layer.borderWidth = 2
        newDataTextField.layer.borderColor = UIColor.white.cgColor
        
        confirmNewDataTextField.layer.cornerRadius = 5
        confirmNewDataTextField.layer.borderWidth = 2
        confirmNewDataTextField.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveDataChangeAction(_ sender: Any) {
        let currentUser = PFUser.current()!
        let username = currentUser.username!
        var email = currentUser.email!
        
        if self.title == "Change Username"{
            //Current username is equal to User's input
            if username == oldDataTextField.text {
                //New username matches confirmation test
                if newDataTextField.text == confirmNewDataTextField.text && newDataTextField.text != ""{
                    currentUser.setValue(newDataTextField.text, forKey: "username")
                    currentUser.saveInBackground()
                    self.dismiss(animated: true, completion: nil)
                }
                //Missing Needed information
                else if newDataTextField.text == "" || confirmNewDataTextField.text == ""
                {
                    let missingInfoAlert = UIAlertController(title: "Missing Information", message: "Make sure you fill in all boxes.", preferredStyle: .alert) //.actionsheet
                    
                    missingInfoAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(missingInfoAlert, animated: true)
                }
                //New Username doesn't match
                else
                {
                    let usernameMissMatchAlert = UIAlertController(title: "New Username Does Not Match", message: "Make sure you type your new username correctly.", preferredStyle: .alert) //.actionsheet
                    
                    usernameMissMatchAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(usernameMissMatchAlert, animated: true)
                }
            }
            //Incorrect current username
            else{
                let usernameAlert = UIAlertController(title: "Incorrect Username", message: "The \"Old Username\" entry is incorrect. Please type in your current username.", preferredStyle: .alert) //.actionsheet
                
                usernameAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(usernameAlert, animated: true)
            }
        }
        else if self.title == "Change Email"{
            //Current email is equal to User's input
            if email == oldDataTextField.text {
                //New email matches confirmation test
                if newDataTextField.text == confirmNewDataTextField.text && newDataTextField.text != ""{
                    currentUser.setValue(newDataTextField.text, forKey: "email")
                    currentUser.saveInBackground()
                    self.dismiss(animated: true, completion: nil)
                }
                //Missing Needed information
                else if newDataTextField.text == "" || confirmNewDataTextField.text == ""
                {
                    let missingInfoAlert = UIAlertController(title: "Missing Information", message: "Make sure you fill in all boxes.", preferredStyle: .alert) //.actionsheet
                    
                    missingInfoAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(missingInfoAlert, animated: true)
                }
                //New email doesn't match
                else
                {
                    let emailMissMatchAlert = UIAlertController(title: "New Email Does Not Match", message: "Make sure you type your new email correctly.", preferredStyle: .alert) //.actionsheet
                    
                    emailMissMatchAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(emailMissMatchAlert, animated: true)
                }
            }
            //Incorrect current email
            else{
                let emailAlert = UIAlertController(title: "Incorrect Email Address", message: "The \"Old Email\" entry is incorrect. Please type in your current email address.", preferredStyle: .alert) //.actionsheet
                
                emailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(emailAlert, animated: true)
            }
            
        }
        else if self.title == "Change Password"{
            
        }
        
        
//        if user["welcomeBack"] as! String == "true" {
//
//            user.setValue("false", forKey: "welcomeBack")
//            user.saveInBackground()
    }
    
}
