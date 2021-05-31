//
//  ShopViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let categories = ["Men's", "Women's", "Bags", "Hats", "Accessories", "Toys"]
    

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
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        
        // Configure the cell
        cell.catLabel.text = categories[indexPath.row] as! String
        
        cell.imgPreview.image = UIImage(named: categories[indexPath.row])
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: collectionView.cellForItem(at:indexPath))
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let shopDetailsVC = segue.destination as! ShopDetailsViewController
        print("Cell index:")
        print(indexPath)
        shopDetailsVC.category = self.categories[indexPath[1]]
        
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
