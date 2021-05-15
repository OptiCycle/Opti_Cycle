//
//  SettingsViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 5/13/21.
//

import UIKit
import Parse


struct Objects {
    var sectionName: String!
    var sectionObjects: [String]!
}

var objectsArray = [Objects]()
var myObject = 0
var mySection = 0

class SettingsViewController: UITableViewController{
    
    var firstDeleteAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        objectsArray = [Objects(sectionName: "Account", sectionObjects: ["Change Username", "Change Email", "Sign Out"]),
                        Objects(sectionName: "Security", sectionObjects: ["Change Password", "Delete Account"])]
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
        cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.highlightedTextColor = UIColor.white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            headerView.textLabel?.textColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //section user clicked cell in
        mySection = indexPath.section
        //cell user clicked on
        myObject = indexPath.row
        
        if objectsArray[mySection].sectionObjects[myObject].prefix(6) == "Change" {
            performSegue(withIdentifier: "ChangeDataSegue", sender: self)
        }
        else if objectsArray[mySection].sectionObjects[myObject] == "Sign Out" {

            let alert = UIAlertController(title: "Sign out?", message: "You will be returned to the login screen.", preferredStyle: .alert) //.actionsheet

            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Sign out", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                
                let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
                
                let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                
                delegate.window?.rootViewController = loginViewController
                
                PFUser.logOut()
            }))

            self.present(alert, animated: true)
        }
        
        else if objectsArray[mySection].sectionObjects[myObject] == "Delete Account" {
            
            let alert1 = UIAlertController(title: "Delete Account?", message: "You'll permanently lose all your data.", preferredStyle: .alert) //.actionsheet

            alert1.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            alert1.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
                
                self.finalWarningAlert()

            }))
            self.present(alert1, animated: true)

        }
        
        
    }
    
    func finalWarningAlert(){
        
        let alert2 = UIAlertController(title: "Delete Account?", message: "Are you sure? This if your final warning and there is no going back! You'll permanently lose ALL your data and progress!", preferredStyle: .alert) //.actionsheet
        
        alert2.addAction(UIAlertAction(title: "No, do not delete my Account.", style: .default, handler: nil))
        
        alert2.addAction(UIAlertAction(title: "Yes, I'm sure. Delete My Account.", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
            
            let currentUser = PFUser.current()!
            let username = currentUser.username!

            let deleteNotif = UIAlertController(title: "Successfully Deleted \(username)'s Account!", message: "", preferredStyle: .alert) //.actionsheet
            self.present(deleteNotif, animated: true)
            
            // change to desired number of seconds (in this case 5 seconds)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                deleteNotif.dismiss(animated: true, completion: nil)
                let main = UIStoryboard(name: "Main", bundle: nil)
                
                let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
                
                let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                
                delegate.window?.rootViewController = loginViewController
                
                if currentUser != nil {
                    //Deletes the user
                    currentUser.deleteInBackground()
                }
            }
            
        }))
        
        self.present(alert2, animated: true)
    }
    
    @IBAction func UnwindChangeDataViewController(unwindSegue: UIStoryboardSegue){}


}
