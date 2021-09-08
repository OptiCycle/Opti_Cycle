











import UIKit
import Parse
import MBCircularProgressBar


class OtherUserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    var displayedUser: PFUser!
    
    
    @IBOutlet weak var plasticsProgressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var badgesProgressBar: MBCircularProgressBarView!
    
    
    @IBOutlet weak var paperProgressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var metalsProgressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var glassProgressBar: MBCircularProgressBarView!
    
    
    @IBOutlet weak var milestoneProgressBar: MBCircularProgressBarView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let query = PFQuery(className:"Badges")
    
    var userBadgeCount: Int = 0
    var gotBadge1: Bool = false
    var gotBadge2: Bool = false
    var gotBadge3: Bool = false
    var gotBadge4: Bool = false
    var gotBadge5: Bool = false
    var gotBadge6: Bool = false
    var gotBadge7: Bool = false
    var gotBadge8: Bool = false
    var gotBadge9: Bool = false
    var gotBadge10: Bool = false
    var gotBadge11: Bool = false
    var gotBadge12: Bool = false
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameLabel.text = self.displayedUser["username"] as! String
        
        if let imageFile: PFFileObject = displayedUser["profileImage"] as? PFFileObject {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {

                        let image = UIImage(data: data!)
                        
                        self.profilePicture.image = image
                        
                        self.profilePicture.layer.masksToBounds = false
                        self.profilePicture.layer.borderColor = UIColor.black.cgColor
                        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
                        self.profilePicture.clipsToBounds = true

                    }
                }
            })
        }

        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back")
        
        self.title = "\(displayedUser["username"] as! String)'s Profile"
        
        print("Entering profile\n\n")
        
        print(displayedUser)
        
        //print(" HEYYYY THIS IS THE TASK:  \(badge[0]["badgeImage])")

        // Do any additional setup after loading the view.
//        print(collectionView)
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
        let user = displayedUser!
        query.whereKey("author", equalTo: displayedUser!)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                // Do something with the found objects
                for object in objects {
                    self.userBadgeCount = (object["badgeCount"] as! Int)
                    self.gotBadge1 = (object["badge1"] as! Bool)
                    self.gotBadge2 = (object["badge2"] as! Bool)
                    self.gotBadge3 = (object["badge3"] as! Bool)
                    self.gotBadge4 = (object["badge4"] as! Bool)
                    self.gotBadge5 = (object["badge5"] as! Bool)
                    self.gotBadge6 = (object["badge6"] as! Bool)
                    self.gotBadge7 = (object["badge7"] as! Bool)
                    self.gotBadge8 = (object["badge8"] as! Bool)
                    self.gotBadge9 = (object["badge9"] as! Bool)
                    self.gotBadge10 = (object["badge10"] as! Bool)
                    self.gotBadge11 = (object["badge11"] as! Bool)
                    self.gotBadge12 = (object["badge12"] as! Bool)
                    self.collectionView.reloadData()
                    self.animateProgressBars(currentUser: user, badgeCount: (object["badgeCount"] as! Int))
                }
            }
        }
    }
    
    func animateProgressBars(currentUser: PFUser, badgeCount: Int) {
        let totalPosts = currentUser["totalPosts"] as! CGFloat
        let metals = currentUser["metal"] as! CGFloat
        let plastics = currentUser["plastic"] as! CGFloat
        let glass = currentUser["glass"] as! CGFloat
        let paper = currentUser["paper"] as! CGFloat
        
        UIView.animate(withDuration: 0.25)
        {
            self.badgesProgressBar.value = CGFloat(badgeCount)
            if totalPosts <= 500 {
                self.milestoneProgressBar.value = totalPosts
            }
            else {
                self.milestoneProgressBar.value = 500
            }
            
            if metals <= 100 {
                self.metalsProgressBar.value = metals
            }
            else {
                self.metalsProgressBar.value = 100
            }
            
            if plastics <= 100 {
                self.plasticsProgressBar.value = plastics
            }
            else {
                self.plasticsProgressBar.value = 100
            }
            
            if paper <= 100 {
                self.paperProgressBar.value = paper
            }
            else {
                self.paperProgressBar.value = 100
            }
            
            if glass <= 100 {
                self.glassProgressBar.value = glass
            }
            else {
                self.glassProgressBar.value = 100
            }
        }
    }
    
    
    var badges: [NSDictionary] = [
        [
            // badge 1
            "badgeImage":  UIImage(named: "1-MilestoneBadge")!,
            "task": "Recycle 50 Pieces of Trash",
        ],[
            // badge 2
            "badgeImage":  UIImage(named: "2-MilestoneBadge")!,
            "task": "Recycle 200 Pieces of Trash"
        ],[
            // badge 3
            "badgeImage":  UIImage(named: "3-MilestoneBadge")!,
            "task": "Recycle 500 Pieces of Trash"
        ],[
            // badge 4
            "badgeImage":  UIImage(named: "50ofEachBadge")!,
            "task": "Recycle 50 of Each Type of Item"
        ],[
            // badge 5
            "badgeImage":  UIImage(named: "250ofEachBadge")!,
            "task": "Recycle 250 of Each Type of Item"
        ],[
            // badge 6
            "badgeImage":  UIImage(named: "500ofEachBadge")!,
            "task": "Recycle 500 of Each Type of Item"
        ],[
            // badge 7
            "badgeImage":  UIImage(named: "plasticsBadge")!,
            "task": "Recycle 100 Plastic Type Items"
        ],[
            // badge 8
            "badgeImage":  UIImage(named: "glassBadge")!,
            "task": "Recycle 100 Glass Type Items"
        ],[
            // badge 9
            "badgeImage":  UIImage(named: "metalsBadge")!,
            "task": "Recycle 100 Metal Type Items"
        ],[
            // badge 10
            "badgeImage":  UIImage(named: "paperBadge")!,
            "task": "Recycle 100 Paper Type Items"
        ],[
            // badge 11
            "badgeImage":  UIImage(named: "firstItemBadge")!,
            "task": "Recycle One Piece of Trash"
        ],[
            // badge 12
            "badgeImage":  UIImage(named: "allBadgesBadge")!,
            "task": "Collect all Badges"
        ],
    ]
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Badge", for: indexPath) as! BadgeCell
        
        let currentBadge = [self.gotBadge1, self.gotBadge2, self.gotBadge3, self.gotBadge4, self.gotBadge5, self.gotBadge6, self.gotBadge7, self.gotBadge8, self.gotBadge9, self.gotBadge10, self.gotBadge11, self.gotBadge12]
        
        if indexPath.row == 10{
            print("Badge ll: ........... \(currentBadge[10])")
        }
        
        // Set up Cell's image
        if currentBadge[indexPath.row] {
            print("in here")
            cell.badgeImageView.image = (badges[indexPath.row]["badgeImage"] as! UIImage)
            cell.badgeImageView.image = (badges[indexPath.row]["badgeImage"] as! UIImage)
            cell.badgeImageView.layer.borderColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
            cell.badgeLabel.textColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0)
        }
        else {
            cell.badgeImageView.image = UIImage(named: "lockedBadge")?.noir
            cell.badgeLabel.textColor = .lightGray
        }
        cell.badgeImageView.backgroundColor = UIColor.darkGray
        cell.badgeImageView.layer.borderWidth = 2
        cell.badgeImageView.layer.masksToBounds = false
        cell.badgeImageView.layer.cornerRadius = cell.badgeImageView.frame.height/2
        cell.badgeImageView.clipsToBounds = true
        
        // Set up Cell's label
        cell.badgeLabel.text = (badges[indexPath.row]["task"] as! String)
        
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
    
    
    
    
    
    
    
    
    
}
