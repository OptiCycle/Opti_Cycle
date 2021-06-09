//
//  ShopViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit

var selectedCategorie = 0
var categories = ["Men's", "Women's", "Bags", "Hats", "Accessories", "Toys"]

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //let categories = ["Men's", "Women's", "Bags", "Hats", "Accessories", "Toys"]
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing: CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
            
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout

//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
//
//        let width = (view.frame.size.width - 10) / 2
//        layout.itemSize = CGSize(width: width, height: width * 1.5)

        
    }
    
    // Equally Sets space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 310)
        }
        else
        {
            return CGSize(width: 0, height: 0)
        }
    }
    // End of equally setting spaces between cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        
        // Configure the cell
        cell.catLabel.text = categories[indexPath.row] as! String
        
        // Cell's Image Rounding
        cell.imgPreview.image = UIImage(named: categories[indexPath.row])
        cell.imgPreview.backgroundColor = UIColor.darkGray
        cell.imgPreview.layer.borderWidth = 2
        cell.imgPreview.layer.masksToBounds = false
        cell.imgPreview.layer.borderColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        cell.imgPreview.layer.cornerRadius = 10//cell.imgPreview.frame.height/2
        cell.imgPreview.clipsToBounds = true
        
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
        cell.layer.shadowColor = UIColor(red: 137/255.0, green: 229/255.0, blue: 158/255.0, alpha: 1.0).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 7.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategorie = indexPath.row
        
        performSegue(withIdentifier: "showDetails", sender: collectionView.cellForItem(at:indexPath))
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let shopDetailsVC = segue.destination as! ShopDetailsController
        print("Cell index:")
        print(indexPath)
        shopDetailsVC.category = categories[indexPath[1]]
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
