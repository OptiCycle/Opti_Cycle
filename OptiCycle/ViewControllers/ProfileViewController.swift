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

    @IBOutlet weak var postsProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var treesProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var badgesProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var badges: [UIImage] = [
        //Not including lockedBadge image
        UIImage(named: "1-MilestoneBadge")!,
        UIImage(named: "2-MilestoneBadge")!,
        UIImage(named: "3-MilestoneBadge")!,
        UIImage(named: "50ofEachBadge")!,
        UIImage(named: "250ofEachBadge")!,
        UIImage(named: "500ofEachBadge")!,
        UIImage(named: "plasticsBadge")!,
        UIImage(named: "glassBadge")!,
        UIImage(named: "metalsBadge")!,
        UIImage(named: "paperBadge")!,
        UIImage(named: "firstItemBadge")!,
        UIImage(named: "allBadgesBadge")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: 180)
        
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
        
        cell.badgeImageView.image = badges[indexPath.row]
        cell.badgeImageView.backgroundColor = UIColor.darkGray
        cell.badgeImageView.layer.borderWidth = 2
        cell.badgeImageView.layer.masksToBounds = false
        cell.badgeImageView.layer.borderColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        cell.badgeImageView.layer.cornerRadius = cell.badgeImageView.frame.height/2
        cell.badgeImageView.clipsToBounds = true
        
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
