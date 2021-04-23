//
//  ProfileViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 4/6/21.
//

import UIKit
import Parse
import MBCircularProgressBar

class ProfileViewController: UIViewController {


    @IBOutlet weak var postsProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var treesProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var badgesProgressBarView: MBCircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.postsProgressBarView.value = 0
        self.treesProgressBarView.value = 0
        self.badgesProgressBarView.value = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Make postsCountLabel equal to amount of posts user has posted
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current()!)
        
        query.countObjectsInBackground { (count: Int32, error: Error?) in
            if let error = error {
                // Request failed
                print(error.localizedDescription)
            } else {
                UIView.animate(withDuration: 2.0) {
                    self.postsProgressBarView.value = CGFloat(count)
                }
            }
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.treesProgressBarView.value = 32
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.badgesProgressBarView.value = 6
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        let user = PFUser.current() as! PFUser
        let username = user.username as! String

        let alert = UIAlertController(title: "Sign out", message: "You will be returned to the login screen", preferredStyle: .alert) //.actionsheet

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sign out", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
            
            PFUser.logOut()
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
            let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
            delegate.window?.rootViewController = loginViewController
        }))

        self.present(alert, animated: true)
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
