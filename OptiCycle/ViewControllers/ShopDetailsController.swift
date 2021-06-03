//
//  ShopDetailsController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit
import Parse

class ShopDetailsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let errorAddress = "https://www.globalsign.com/application/files/9516/0389/3750/What_Is_an_SSL_Common_Name_Mismatch_Error_-_Blog_Image.jpg"
    
    var category = String()
//    var searchQuery = String()
    
    var items = [PFObject]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5

        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 2)

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
        // Do any additional setup after loading the view.
        
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
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopDetailsCollectionViewCell", for: indexPath) as! ShopDetailsCollectionViewCell
        
        let item = items[indexPath.row]
        
        cell.itemLabel.text = item["Name"] as! String
        cell.priceLabel.text = item["Price"] as! String
        cell.url = item["URL"] as! String
        cell.brandLabel.text = item["Brand"] as! String

        let my_imgUrl = item["Image_URL"] as! String
        let img_url = URL(string: my_imgUrl ?? errorAddress) as! URL
        if let data = try? Data(contentsOf : img_url) {
            cell.itemImage.image = UIImage(data : data as! Data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ShopDetailsCollectionViewCell
        let myUrl = cell.url as! String
        let url = (URL(string: myUrl))!
        UIApplication.shared.open(url)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
