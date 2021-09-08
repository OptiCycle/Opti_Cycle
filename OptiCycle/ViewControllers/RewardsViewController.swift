//
//  RewardsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 9/4/21.
//

import UIKit
import MBCircularProgressBar
import Parse

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var rewardsProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var itemsLeftLabel: UILabel!
    @IBOutlet weak var numRewardsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var rewards = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let user = PFUser.current() as! PFUser
        let numItems = user["DiscountProgress"] as! Int
        self.rewards = user["Rewards"] as? Array<Any> ?? []
        rewardsProgressBar.value = CGFloat(numItems)
        itemsLeftLabel.text = "Recycle " + String(30-numItems) + " more items to earn your next reward"
        numRewardsLabel.text = "You have " + String(rewards.count) + " rewards:"
        
        //Check if user has a discount here!!
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(self.rewards.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell") as! RewardCell
        
        if rewards.count==0 && indexPath.row==0{
            cell.brandLabel.text = "No Rewards"
            cell.rewardImage.image = nil
            cell.descriptionLabel.text = "Fill your progress bar to earn your first reward!"
        }
        
        return cell
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
