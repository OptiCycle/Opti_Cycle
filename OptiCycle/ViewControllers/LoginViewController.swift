//
//  LoginViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/1/21.
//

import UIKit
import Parse
import Lottie

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var animationView: AnimationView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color of mintGreen being used is:
        // UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        
        usernameField.layer.cornerRadius = 5
        usernameField.layer.borderWidth = 2
        usernameField.layer.borderColor = UIColor.white.cgColor
        
        passwordField.layer.cornerRadius = 5
        passwordField.layer.borderWidth = 2
        passwordField.layer.borderColor = UIColor.white.cgColor
        
        signinButton.backgroundColor = .clear
        signinButton.layer.cornerRadius = 5
        signinButton.layer.borderWidth = 2
        signinButton.layer.borderColor = UIColor.white.cgColor
        
        signupButton.backgroundColor = .clear
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.black.cgColor
        
        animationView = .init(name: "54940-recycle-icon-animation")
        animationView!.frame = CGRect(x: view.frame.width / 3 + 15, y: 175, width: 100, height: 100)
        
        startAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        startAnimations()
    }
    
    func startAnimations() {
        
        animationView!.contentMode = .scaleAspectFill
        view.addSubview(animationView!)
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.25
        animationView!.play()
    }

    @IBAction func onLogin(_ sender: Any) {
        let usrname = usernameField.text!
        let pass = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: usrname, password: pass)
        { (user, error) in
            if user != nil{
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                
                let user = PFUser.current() as! PFUser
                user["welcomeBack"] = "true"
            }
            else{
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                
                print("error: \(error?.localizedDescription)")
                
                let incorrectCredentialAlert = UIAlertController(title: "Login Failed", message: "Your username or password is incorrect or doesn't exist.", preferredStyle: .alert) //.actionsheet
                
                incorrectCredentialAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(incorrectCredentialAlert, animated: true)
            }
            
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func UnwindSignUpViewController(unwindSegue: UIStoryboardSegue){}
    

}
