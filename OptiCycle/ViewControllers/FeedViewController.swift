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
    
//    var refreshControl: UIRefreshControl!
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        tableView.refreshControl = refreshControl
        
        refreshData()
        
        tableView.delegate = self
        tableView.dataSource = self
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
//        self.refreshControl.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//        let post = posts[indexPath.row]
//        let user = post["author"] as! PFUser
//        let name = user.username as! String
//        let item = post["item"] as! String
//        let conf = post["confidence"] as! String
//        cell.postLabel.text = name + " recycled " + item + " with a confidence of " + conf
//        let imageLabel = post["image_label"] as! String
//        cell.postImage.image = UIImage(named: imageLabel)
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
