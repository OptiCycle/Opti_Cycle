//
//  LocalStandardsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/10/21.
//

import UIKit

class LocalStandardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var localtableView: UITableView!
    var location = "State College"
    let stateCollege = [[
        "type": "Batteries and Bulbs",
        "preview": "Some batteries and bulbs can be recycled. Check out our Batteries & Bulbs Fact Sheet for more information.",
        "image": "batteries-bulbs-poster",
        "url": "https://www.centrecountyrecycles.org/index.asp?SEC=85B24A99-4657-470E-BE67-90775D02F24C"],
        ["type": "Business/Office Recycling",
         "preview": "Business and office recycling is mandatory in State College and Bellefonte Boroughs, the surrounding Townships in the Centre Region as well as Benner & Spring Townships. Our Commercial Recycling specialists can: Help identify recyclable materials, Suggest waste reduction tips, Provide assistance in obtaining recycling containers, Train your employees, Conduct a free waste assessment, Provide free education material and signage",
         "image": "business-poster",
         "url": "https://www.centrecountyrecycles.org/businessrecycling"],
        ["type": "Curbside Recycling",
         "preview": "Residents should have recycling bins and trash containers set out by the time pickup crews begin collection at 7:00 a.m. Curbside recycling collection is done weekly, on the same day as trash pickup.",
         "image": "curbside-poster",
         "url": "https://www.centrecountyrecycles.org/curbsiderecycling"],
        ["type": "Drop Off Recycling",
         "preview": "Centre County has recycling drop off locations for residents to use for recycling various materials. These drop-offs are available 24 hours a day, 7 days a week. Most locations are equipped with compartmentalized containers handling six categories of materials.",
         "image": "drop-off-poster",
         "url": "https://www.centrecountyrecycles.org/dropoffrecycling"],
        ["type": "Electronics Recycling",
         "preview": "Act 108 of 2010 (The Covered Device Recycling Act), bans all covered devices from landfills, however, the Centre County Recycling & Refuse Authority offers a free drop off service for residents.  Covered Devices includes desktop computers, monitors, laptops, computer peripherals and televisions. ",
         "image": "electronics-poster",
         "url": "https://www.centrecountyrecycles.org/electronicsrecycling"],
        ["type": "Misc. Plastics Recycling",
         "preview": "Although we do not accept miscellaneous plastic containers curbside, we do provide six locations to recycle items such as: yogurt containers, margarine containers, strawberry/blueberry/lettuce containers, etc. If a container does not fit in the Miscellaneous Plastic drop off box, please do not leave the container outside of the box.",
         "image": "misc-plastics-poster",
         "url": "https://www.centrecountyrecycles.org/plasticsrecycling"],
        
    ]
    
    let boulder = [[
                    "type": "Recycling Guidelines",
                    "preview": "Please follow the intructions on the poster when recycling.",
                    "image": "https://www.ecocycle.org/images/guidelines/recycle-thumb.PNG",
                    "url": "https://www.ecocycle.org/files/pdfs/guidelines/ecocycle_recycling-guidelines_web.pdf"],
                   ["type": "Recycling Contaminants: Dirty Dozen",
                    "preview": "Avoid disposing of these items in recycling bins.",
                    "image": "https://www.ecocycle.org/images/guidelines/dirty-dozen-guide-thumb.png",
                    "url": "https://www.ecocycle.org/files/pdfs/guidelines/ecocycle_recycling-contaminants_web.pdf"],
                   ["type": "Curbside Composting",
                    "preview": "Only compost the types of items listed in the poster",
                    "image": "https://www.ecocycle.org/images/guidelines/compost-guide-thumb.png",
                    "url": "https://www.ecocycle.org/files/pdfs/guidelines/ecocycle_compost-guidelines_web.pdf"],
                    ["type": "Plastic Bags and Bubble Wrap",
                     "preview": "Large plastics such as Big Wheels® and plastic play structures, plastic lawn furniture, plastic watering cans, laundry baskets, clean plastic buckets (no residue), crates, rigid backyard kiddie pools and plastic trash containers.",
                     "image": "https://www.ecocycle.org/images/CHaRM/ecocycle-foam-packing-sheet_500.jpg",
                     "url": "https://www.ecocycle.org/charm#plasticbagsbubblewrap"],
                    ["type": "Electronics",
                     "preview": "CRT (not flatscreen) TVs, rear-projection TVs, Monitors: $0.69/lb NOTE:  Broken CRT glass is classified by the EPA as hazardous waste, and requires extra handling and documentation. Price for broken CRT glass is $1.00/lb.",
                     "image": "https://www.ecocycle.org/images/CHaRM/printer-cartridges_web.jpg",
                     "url": "https://www.ecocycle.org/charm#electronics"],
                    ]
    var library = [[String: String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        localtableView.dataSource = self
        localtableView.delegate = self
        searchBar.delegate = self
        library = stateCollege
        
        
        localtableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalStandardsViewCell") as! LocalStandardsViewCell
        
        let info = self.library[indexPath.row] as! [String:Any]
        
        cell.typeLabel.text = info["type"] as! String
        cell.previewLabel.text = info["preview"] as! String
        
        if location == "State College"{
            cell.itemImage.image = UIImage(named: info["image"] as! String)
        }
        else if location == "Boulder"{
            let my_imgUrl = info["image"] as! String
            let img_url = URL(string: my_imgUrl) as! URL
            if let data = try? Data(contentsOf : img_url) {
                cell.itemImage.image = UIImage(data : data as! Data)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myUrl = library[indexPath.row]["url"] as! String
        let url = (URL(string: myUrl) ?? URL(string: "https://www.centrecountyrecycles.org/"))!
        UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        if text == "Boulder"{
            library = boulder
            location = "Boulder"
        }
        else if text == "State College"{
            library = stateCollege
            location = "State College"
        }
        localtableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
