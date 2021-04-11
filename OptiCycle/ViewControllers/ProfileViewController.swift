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

    @IBOutlet weak var progressBarView: MBCircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progressBarView.value = 0
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
                    self.progressBarView.value = CGFloat(count)
                }
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
        
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
