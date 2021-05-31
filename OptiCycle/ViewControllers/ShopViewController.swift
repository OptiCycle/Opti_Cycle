//
//  ShopViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let shopItems = ["Tops": [
                        ["label": "Classic Tee",
                        "img url": "https://cdn.shopify.com/s/files/1/1174/9052/products/RS100_Carbon_2c36675e-81a7-4a1b-a487-0cbe73dac45f_large.jpg?v=1583353285",
                        "url": "https://recoverbrands.com/collections/mens/products/recover-tee?variant=13008189554711"],
                              
                        ["label": "Pocket Tee",
                         "img url":"https://cdn.shopify.com/s/files/1/1174/9052/products/RSPNavy_large.png?v=1585587281",
                         "url": "https://recoverbrands.com/collections/mens/products/pocket-tee?variant=31805913432112"]
                    ],
                "Shorts": [],
                "Pants": [],
                "Athletic Wear": [],
                "Shoes": [],
                "Bags": [],
                "Hats": [],
                "Outer Wear": [],
                "Accessories": [],
                "Toys": []
    ] as [String : Any]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5

        let width = (view.frame.size.width - 10) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.5)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        
        // Configure the cell
        cell.catLabel.text = Array(shopItems)[indexPath.row].key as! String
        cell.imgPreview.image = UIImage(named: "plastics")
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: collectionView.cellForItem(at:indexPath))
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let shopDetailsVC = segue.destination as! ShopDetailsViewController
        
        collectionView.deselectItem(at: indexPath, animated: true)
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
