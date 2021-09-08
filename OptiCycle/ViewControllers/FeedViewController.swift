//
//  FeedViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/1/21.
//

import UIKit
import Parse
import MBCircularProgressBar

// Add UITableViewDataSource
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    var currentDay = NSDate()
    var refreshControl: UIRefreshControl!
    var posts = [PFObject]()
    var numItemsToday = 0
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x:0, y:0, width: 60, height:60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 1
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 180 - 8,
                                      y: view.frame.size.height - 150 - 8,
                                      width: 180,
                                      height: 60)
        floatingButton.setTitle("Recycle", for: .normal)
        floatingButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
    }
    
    @objc private func didTapButton() {
        performSegue(withIdentifier: "scanSegue", sender: self)
    }
       
    func checkDate(){
        let date = NSDate()
        if abs(currentDay.timeIntervalSince(date as Date)/3600.0) >= 24{
            currentDay = NSDate()
            let user = PFUser.current() as! PFUser
            user.setValue(0, forKey: "ItemsToday")
            user.saveInBackground()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = .systemGreen
        
        refreshData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
                                                                       
        let user = PFUser.current() as! PFUser

        print(user["firstTimer"] as! String)
        
        if user["firstTimer"]  as! String == "true" {
            
            let username = user.username as! String

            let alert = UIAlertController(title: "Hello \(username), welcome to Opticycle!", message: "Opticycle is an app that helps you recycle more effectively. You are currently on the Home page where any posts you make will appear.\n\nTap the camera in the top right to begin scanning recyclables", preferredStyle: .alert) //.actionsheet

            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        } else {
            
            print("yo")
            
            if user["welcomeBack"] as! String == "true" {
                
                user.setValue("false", forKey: "welcomeBack")
                user.saveInBackground()
                
                let username = user.username as! String

                let alert = UIAlertController(title: "Welcome back \(username)", message: "", preferredStyle: .alert) //.actionsheet
                
                alert.view.tintColor = UIColor.green;
                self.present(alert, animated: true)

    //            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        user.setValue("false", forKey: "firstTimer")
        user.saveInBackground()
        
        print(user["firstTimer"]  as! String)



    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }
    
    @objc func refreshData(){
        
        checkDate()
        
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 200
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.posts.reverse()
                self.tableView.reloadData()
            }
        }
        let user = PFUser.current() as! PFUser
        self.numItemsToday = user["ItemsToday"] as! Int
       
        
        
        self.refreshControl.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row==0{
            //today progress cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
            let user = PFUser.current() as! PFUser
            let username = user.username as! String
            
            cell.greetingLabel.text = "Hello " + username + "!"
            UIView.animate(withDuration: 0.25){
                let todayCount = min(5, self.numItemsToday)
                cell.circleBar.value = CGFloat(todayCount)
            }
            cell.numItemsLabel.text = String(self.numItemsToday) + " items recycled today"
            cell.rewardsButton.layer.cornerRadius = 20
            cell.rewardsButton.layer.borderWidth = 2
            cell.rewardsButton.layer.borderColor = cell.rewardsButton.layer.backgroundColor
            
            return cell
        }
        else{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let post = posts[indexPath.row-1]
            let user = post["author"] as! PFUser
            let name = user.username as! String
            let item = post["item"] as! String
            
            
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]));
            text.append(NSAttributedString(string: " recycled " + item, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
            
            cell.postLabel.attributedText = text
            
            
            
            
    //        cell.postLabel.text = name + " recycled " + item + " with a confidence of " + conf
    //        let imageLabel = post["image_label"] as! String
    //        cell.postImage.image = UIImage(named: imageLabel)

            if let imageFile: PFFileObject = user["profileImage"] as? PFFileObject {
                imageFile.getDataInBackground(block: { (data, error) in
                    if error == nil {
                        DispatchQueue.main.async {

                            let image = UIImage(data: data!)
                            
                            cell.postImage.image = image
                            
    //                        cell.postImage.layer.borderWidth = 2
                            cell.postImage.layer.masksToBounds = false
    //                        cell.profilePicture.layer.borderColor = UIColor.green.cgColor
                            cell.postImage.layer.cornerRadius = cell.postImage.frame.height/2
                            cell.postImage.clipsToBounds = true

                        }
                    }
                })
            }
            
            user.saveInBackground()
            return cell
        }
        
        
    }
    
    
    
    @IBAction func onInfo(_ sender: Any) {
        
        let user = PFUser.current() as! PFUser

        let username = user.username as! String

        let alert = UIAlertController(title: "About Opticycle", message: "Opticycle is an app that helps you recycle more effectively. You are currently on the Home page where any posts you make will appear.\n\nTap the camera in the top right to begin scanning recyclables", preferredStyle: .alert) //.actionsheet

        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

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
