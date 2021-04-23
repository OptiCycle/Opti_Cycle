//
//  FeedViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/1/21.
//

import UIKit
import Parse

// Add UITableViewDataSource
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        refreshData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
            
        let user = PFUser.current() as! PFUser

        print(user["firstTimer"] as! String)
        
        if user["firstTimer"]  as! String == "true" {
            
            let username = user.username as! String

            let alert = UIAlertController(title: "Hello \(username), welcome to Opticycle!", message: "Opticycle is an app that helps you recycle more effectively. You are currently on the Home/Feed page where any posts you make will appear.\n\n-Tap the camera in the top right to begin scanning recyclables\n-Tap the bottom middle icon to see Local Recycling Standards\n-Tap the bottom right to go to your profile page", preferredStyle: .alert) //.actionsheet

            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        } else {
            
            print("yo")
            let username = user.username as! String

            let alert = UIAlertController(title: "Welcome back \(username)", message: "", preferredStyle: .alert) //.actionsheet
            
            alert.view.tintColor = UIColor.green;
            self.present(alert, animated: true)

//            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                alert.dismiss(animated: true, completion: nil)
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
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 30
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.posts.reverse()
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        let name = user.username as! String
        let item = post["item"] as! String
        let conf = post["confidence"] as! String
        cell.postLabel.text = name + " recycled " + item + " with a confidence of " + conf
        let imageLabel = post["image_label"] as! String
        cell.postImage.image = UIImage(named: imageLabel)
        return cell
    }
    
    
    
    @IBAction func onInfo(_ sender: Any) {
        
        let user = PFUser.current() as! PFUser

        let username = user.username as! String

        let alert = UIAlertController(title: "About Opticycle", message: "Opticycle is an app that helps you recycle more effectively. You are currently on the Home page where any posts you make will appear.\n\n-Tap the camera in the top right to begin scanning recyclables\n-Tap the bottom middle icon to see Local Recycling Standards\n-Tap the bottom right icon to go to your profile page", preferredStyle: .alert) //.actionsheet

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
