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
    
    var animationView: AnimationView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
            else{
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                print("error: \(error?.localizedDescription)")
            }
            
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        // ** assigns default profile picture
//        let image = UIImage(systemName: "person.crop.circle.fill")
//        let userImage = UIImageView(image: image!)
//        let imageData = userImage.image!.pngData()
//        let file = PFFileObject(data: imageData!)
//        user["profileImage"] = NSNull.self
        // **
        
        user.signUpInBackground { (success, error) in
            if success{
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            }
            else{
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                print("bruh")
                print("error: \(error?.localizedDescription)")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
