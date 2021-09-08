//
//  ShopDetailsController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit
import Parse

class ShopDetailsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let errorAddress = "https://www.globalsign.com/application/files/9516/0389/3750/What_Is_an_SSL_Common_Name_Mismatch_Error_-_Blog_Image.jpg"
    
    var category = String()
//    var searchQuery = String()
    
    var items = [PFObject]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing: CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if categories[selectedCategorie] == "Men's"{
            self.title = "Men's"
        }
        else if categories[selectedCategorie] == "Women's"{
            self.title = "Women's"
        }
        else if categories[selectedCategorie] == "Bags"{
            self.title = "Bags"
        }
        else if categories[selectedCategorie] == "Hats"{
            self.title = "Hats"
        }
        else if categories[selectedCategorie] == "Accessories"{
            self.title = "Accessories"
        }
        else if categories[selectedCategorie] == "Toys"{
            self.title = "Toys"
        }
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
//
//        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
//        layout.itemSize = CGSize(width: width, height: width * 2)

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
    
    // Equally Sets space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 400)
        }
        else
        {
            return CGSize(width: 0, height: 0)
        }
    }
    // End of equally setting spaces between cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopDetailsCollectionViewCell", for: indexPath) as! ShopDetailsCollectionViewCell
        
        let item = items[indexPath.row]
        
        // Instantiate Cell Elements
        cell.itemLabel.text = item["Name"] as! String
        cell.priceLabel.text = item["Price"] as! String
        cell.url = item["URL"] as! String
        cell.brandLabel.text = item["Brand"] as! String

        let my_imgUrl = item["Image_URL"] as! String
        let img_url = URL(string: my_imgUrl ?? errorAddress) as! URL
        if let data = try? Data(contentsOf : img_url) {
            cell.itemImage.image = UIImage(data : data as! Data)
        }
        
        // Cell's Image Rounding
        cell.itemImage.backgroundColor = UIColor.systemGray4
//        cell.itemImage.layer.borderWidth = 2
        cell.itemImage.layer.masksToBounds = false
//        cell.itemImage.layer.borderColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        cell.itemImage.layer.cornerRadius = 10//cell.imgPreview.frame.height/2
        cell.itemImage.clipsToBounds = true
        
        // cell rounded section
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        // cell shadow section
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
//        cell.layer.backgroundColor = UIColor.systemGray2.cgColor
        
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

}
