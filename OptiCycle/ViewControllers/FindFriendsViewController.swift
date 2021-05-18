//
//  FindFriendsViewController.swift
//  OptiCycle
//
//  Created by Max Skeen on 5/17/21.
//

import UIKit
import Parse
import AlamofireImage

class FindFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [PFObject]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"_User")
        
//        query.includeKey("objectId")
        query.limit = 20
        
        query.findObjectsInBackground { (users, error) in
            if users != nil {
                self.users = users!
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
    
        let user = users[indexPath.row]
        
        // set username
        let username = user["username"] as! String
        cell.usernameLabel.text = username
        print(username)
        
        //set the number of posts made
        let numOfPosts = "Posts made: 0"
        cell.numberOfPostsLabel.text = numOfPosts
        
        //set the profile picture
        if let imageFile: PFFileObject = user["profileImage"] as? PFFileObject {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {

                        let image = UIImage(data: data!)

                        cell.profilePicture.image = image
                    }
                }
            })
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
