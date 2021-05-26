//
//  FindFriendsViewController.swift
//  OptiCycle
//
//  Created by Max Skeen on 5/17/21.
//

import UIKit
import Parse
import AlamofireImage

class FindFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var users = [PFObject]()
    var filteredUsers = [PFObject]()
    var buttons = [UIButton]()
    
    @IBAction func goToProfile(_ sender: Any) {
        
        
        var correctUser = users[0]
        
        // find correct user
        for i in 0..<buttons.count {
            if buttons[i] == sender as! NSObject {
                correctUser = users[i]
            }
        }
        
        let username = correctUser["username"] as! String
        print("\n\(username) was clicked!")
        
        print("Created at \(correctUser.createdAt as! Date)")
        correctUser.setValue("Does it work?", forKey: "test")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"_User")
        
//        query.includeKey("objectId")
//        query.limit = 20
        
        query.findObjectsInBackground { (users, error) in
            if users != nil {
                self.users = users!
                self.filteredUsers = self.users
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        
        if text.isEmpty {
            self.filteredUsers = self.users
            print("No text")
        } else {
            
            self.filteredUsers = self.users.filter({ (user: PFObject) -> Bool in

                let username = user["username"] as! String
                if username.range(of: text, options: .caseInsensitive, range: nil, locale: nil) != nil {
                    return true
                } else {
                    return false
                }
            })

        }
        
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        
        cell.selectionStyle = .none
        cell.background.layer.cornerRadius = 10
        cell.background.layer.masksToBounds = true

        let user = filteredUsers[indexPath.row]
        
        // set username
        let username = user["username"] as! String
        cell.usernameLabel.text = username
        print(username)
        
        cell.button.setTitle(username, for: .normal)
        cell.button.setTitleColor(UIColor.clear, for: .normal)
        
        //Dont add to array if already in array
        if buttons.contains(cell.button) {
            print("Already added in array")
        }
        
        else {
            buttons.append(cell.button)
        }

        //set the number of posts made
        let numOfPosts = "Objects Recycled: "
        cell.numberOfPostsLabel.text = numOfPosts
        
        //set the profile picture
        if let imageFile: PFFileObject = user["profileImage"] as? PFFileObject {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {

                        let image = UIImage(data: data!)
                        
                        cell.profilePicture.image = image
                        
                        cell.profilePicture.layer.borderWidth = 2
                        cell.profilePicture.layer.masksToBounds = false
                        cell.profilePicture.layer.borderColor = UIColor.green.cgColor
                        cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.height/2
                        cell.profilePicture.clipsToBounds = true

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
