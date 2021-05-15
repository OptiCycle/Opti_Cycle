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
        query.whereKey("author", equalTo: PFUser.current() ?? nil)
        
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
            self.treesProgressBarView.value = 0
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.badgesProgressBarView.value = 0
        }
    }

    @IBAction func UnwindSettingsViewController(unwindSegue: UIStoryboardSegue){}
}
