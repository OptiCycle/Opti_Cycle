//
//  ShopDetailsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 5/31/21.
//

import UIKit

class ShopDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let errorAddress = "https://www.globalsign.com/application/files/9516/0389/3750/What_Is_an_SSL_Common_Name_Mismatch_Error_-_Blog_Image.jpg"
    
    let shopMenItems = ["Tops": [
                        ["label": "recover Classic Tee",
                         "price": "$25.00",
                        "img url": "https://cdn.shopify.com/s/files/1/1174/9052/products/RS100_Carbon_2c36675e-81a7-4a1b-a487-0cbe73dac45f_large.jpg?v=1583353285",
                        "url": "https://recoverbrands.com/collections/mens/products/recover-tee?variant=13008189554711"],
                              
                        ["label": "recover Pocket Tee",
                         "price": "$25.00",
                         "img url":"https://cdn.shopify.com/s/files/1/1174/9052/products/RSPNavy_large.png?v=1585587281",
                         "url": "https://recoverbrands.com/collections/mens/products/pocket-tee?variant=31805913432112"]],
                     
                "Shorts": [
                        ["label": "Repreve Eco Short",
                         "price": "$22.98",
                         "img url":"https://www.haggar.com/dw/image/v2/BBND_PRD/on/demandware.static/-/Sites-master-catalog-haggar/default/dwfcd55ae4/images/hi-res/HS10430_038.jpg?sw=2000&sh=2000&sm=fit",
                         "url": "https://www.haggar.com/repreve-eco-short/regular-fit-flat-front-flex-waistband/HS10430.html"],
                        ["label": "HYPERFREAK HYDRO 20 BOARDSHORTS",
                         "img url":"https://cdn.shopify.com/s/files/1/2034/7683/products/hyperfreakhydro_SP9106000_blk2_5_900x.jpg?v=1581486344",
                         "url": "https://us.oneill.com/products/sp0106000-blk-hyperfreak-hydro"]],
                
                "Pants": [
                        ["label": "",
                         "price": "",
                         "img url":"",
                         "url": ""]],
                "Athletic Wear": [],
                "Shoes": [],
                "Outer Wear": []
                
    ] as [String : Array<Dictionary<String, String>>]
    
    let shopWomenItems = ["Tops": [
                        ["label": "",
                         "price": "",
                        "img url": "",
                        "url": ""],
                              
                        ["label": "",
                         "price": "",
                         "img url":"",
                         "url": ""]],
                     
                "Shorts": [
                        ["label": "Lo Down 2 Shorts",
                         "price": "$19.99",
                        "img url":"https://images.boardriders.com/globalGrey/roxy-products/all/default/xlarge/arjbs03063_lodownshort2,w_kvj0_frt1.jpg",
                         "url": "https://www.roxy.com/lo-down-2%22-shorts-ARJBS03063.html"],
                        ["label": "",
                         "img url":"",
                         "url": ""]],
                
                "Pants": [
                        ["label": "",
                         "img url":"",
                         "url": ""]],
                "Athletic Wear": [],
                "Shoes": [],
                "Outer Wear": []
                
    ] as [String : Array<Dictionary<String, String>>]
    
    var category = String()
    
    var items = [String: Any]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailsCell") as! ShopDetailsCell
        let item = shopMenItems["Tops"]![indexPath.row]
        
        print("Item array:")
        print(item)
        
        cell.nameLabel.text = item["label"]!
        cell.priceLabel.text = item["price"]!
        cell.url = item["url"]!


        let img_url = URL(string: item["img url"] ?? errorAddress) as! URL
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
