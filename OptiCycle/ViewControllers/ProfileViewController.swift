//
//  ProfileViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 4/6/21.
//

import UIKit
import Parse
import MBCircularProgressBar

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var plasticsProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var badgesProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var paperProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var metalsProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var glassProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var milestoneProgressBar: MBCircularProgressBarView!
    
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var badges: [NSDictionary] = [
        [
            "badgeImage":  UIImage(named: "1-MilestoneBadge")!,
            "task": "Recycle 50 Pieces of Trash"
        ],[
            "badgeImage":  UIImage(named: "2-MilestoneBadge")!,
            "task": "Recycle 200 Pieces of Trash"
        ],[
            "badgeImage":  UIImage(named: "3-MilestoneBadge")!,
            "task": "Recycle 500 Pieces of Trash"
        ],[
            "badgeImage":  UIImage(named: "50ofEachBadge")!,
            "task": "Recycle 50 of Each Type of Item"
        ],[
            "badgeImage":  UIImage(named: "250ofEachBadge")!,
            "task": "Recycle 250 of Each Type of Item"
        ],[
            "badgeImage":  UIImage(named: "500ofEachBadge")!,
            "task": "Recycle 500 of Each Type of Item"
        ],[
            "badgeImage":  UIImage(named: "plasticsBadge")!,
            "task": "Recycle 100 Plastic Type Items"
        ],[
            "badgeImage":  UIImage(named: "glassBadge")!,
            "task": "Recycle 100 Glass Type Items"
        ],[
            "badgeImage":  UIImage(named: "metalsBadge")!,
            "task": "Recycle 100 Metal Type Items"
        ],[
            "badgeImage":  UIImage(named: "paperBadge")!,
            "task": "Recycle 100 Paper Type Items"
        ],[
            "badgeImage":  UIImage(named: "firstItemBadge")!,
            "task": "Recycle One Piece of Trash"
        ],[
            "badgeImage":  UIImage(named: "allBadgesBadge")!,
            "task": "Collect all Badges"
        ],
    ]
    
    var test: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(" HEYYYY THIS IS THE TASK:  \(badge[0]["badgeImage"])")

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.plasticsProgressBar.value = 0
        self.paperProgressBar.value = 0
        self.metalsProgressBar.value = 0
        self.glassProgressBar.value = 0
        self.milestoneProgressBar.value = 0
        self.badgesProgressBar.value = 0

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
                    self.milestoneProgressBar.value = CGFloat(count)
                }
            }
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.plasticsProgressBar.value = 50
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.badgesProgressBar.value = 6
        }

        
        UIView.animate(withDuration: 2.0)
        {
            self.milestoneProgressBar.value = 375
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.glassProgressBar.value = 39
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.paperProgressBar.value = 22
        }
        
        UIView.animate(withDuration: 2.0)
        {
            self.metalsProgressBar.value = 64
        }
    }
    
    // Editting Cell spacing and size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = collectionView.bounds.width/3.0

        return CGSize(width: 135, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    // End of editting cell spacing and size
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Badge", for: indexPath) as! BadgeCell
        
        // Set up Cell's image
        if test {
            cell.badgeImageView.image = (badges[indexPath.row]["badgeImage"] as! UIImage)
        }
        else {
            cell.badgeImageView.image = UIImage(named: "lockedBadge")
        }
        cell.badgeImageView.backgroundColor = UIColor.darkGray
        cell.badgeImageView.layer.borderWidth = 2
        cell.badgeImageView.layer.masksToBounds = false
        cell.badgeImageView.layer.borderColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        cell.badgeImageView.layer.cornerRadius = cell.badgeImageView.frame.height/2
        cell.badgeImageView.clipsToBounds = true
        
        // Set up Cell's label
        cell.badgeLabel.text = (badges[indexPath.row]["task"] as! String)
        
        // Color of mintGreen being used is:
        // UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        
        // cell rounded section
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.masksToBounds = true
        
        // cell shadow section
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.6
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        
        return cell
    }

    @IBAction func UnwindSettingsViewController(unwindSegue: UIStoryboardSegue){}
}
