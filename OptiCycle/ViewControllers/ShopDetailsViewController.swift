//
//  ShopDetailsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit
import Parse

class ShopDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let errorAddress = "https://www.globalsign.com/application/files/9516/0389/3750/What_Is_an_SSL_Common_Name_Mismatch_Error_-_Blog_Image.jpg"
    
    var category = String()
//    var searchQuery = String()
    
    var items = [PFObject]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        switch category {
//        case "Men's":
//            searchQuery = "MenShopItems"
//        case "Women's":
//            searchQuery = "WomenShopItems"
//        case "Bags":
//            searchQuery = "BagsShopItems"
//        case "Hats":
//            searchQuery = "HatsShopItems"
//        case "Accessories":
//            searchQuery = "AccessoriesShopItems"
//        case "Toys":
//            searchQuery = "ToysShopItems"
//        default:
//            break
//        }
        //add rest of search queries
        
        refreshData()
        
        
        
    }
    func refreshData(){
        let query = PFQuery(className:"MenShopItems")
        query.limit = 50
        query.whereKey("Class", equalTo: category)
        //add filter conditional statement for additional query
            
        
        query.findObjectsInBackground{ (list, error) in
            if list != nil{
                self.items = list!
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailsCell") as! ShopDetailsCell
        
        let item = items[indexPath.row]
        
        print("Item array:")
        print(item)
        
        cell.nameLabel.text = item["Name"] as! String
        cell.priceLabel.text = item["Price"] as! String
        cell.url = item["URL"] as! String

        let my_imgUrl = item["Image_URL"] as! String
        let img_url = URL(string: my_imgUrl ?? errorAddress) as! URL
        if let data = try? Data(contentsOf : img_url) {
            cell.itemImage.image = UIImage(data : data as! Data)
        }

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ShopDetailsCell
        let myUrl = cell.url as! String
        let url = (URL(string: myUrl))!
        UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: true)
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
