//
//  ResultsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/10/21.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var revealLabel: UILabel!
    @IBOutlet weak var disposeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var type = ""
    var articleLinks = ["https://harmony1.com/common-mistakes-people-make-when-recycling-infographic/",
                        "https://www.recycling.com/paper-recycling/", "https://www.cnet.com/home/kitchen-and-household/how-to-recycle-all-your-metal-cans-dos-and-donts-earth-day-2021/", "https://recyclenation.com/2017/11/5-quick-tips-to-recycle-more-plastic/",
                        "https://owlcation.com/stem/How-plastic-is-really-recycled", "https://lbre.stanford.edu/pssistanford-recycling/frequently-asked-questions/frequently-asked-questions-glass-recycling"]
    
    let articles = ["https://harmony1.com/common-mistakes-people-make-when-recycling-infographic/":
                        ["title":"Common Mistakes People Make When Recycling",
                         "description":"Recycling isn’t always black and white. Here is a quick list of common mistakes that people make when recycling."],
                    "https://recyclenation.com/2017/11/5-quick-tips-to-recycle-more-plastic/":
                        ["title":"5 Quick Tips to Recycle More Plastic",
                         "description":"Whenever possible it’s best to buy and use reusable items, but when faced with the inevitable plastic, here are 5 quick tips to recycle more plastic. 1. You can recycle ALL plastic bottles."],
                    "https://www.recycling.com/paper-recycling/":
                        ["title":"Sorting Waste Paper at Home for Recycling",
                         "description":"Paper recycling is the circular process of turning old waste paper into new paper, this recycling and producing process is called papermaking. Paper is a 100% natural and recyclable resource made of wood fibers."],
                    "https://www.cnet.com/home/kitchen-and-household/how-to-recycle-all-your-metal-cans-dos-and-donts-earth-day-2021/":
                        ["title":"How to recycle all your metal cans: Do's and don'ts",
                         "description":"Now's the time to think of all the cans you go through weekly -- canned food, aerosol cans, soda cans. Fortunately, all metal cans -- including aluminum and steel -- are infinitely recyclable and, according to the American and Iron Steel Institute, more than 90% of the co-products from the steelmaking process are reused or recycled."],
                    "https://owlcation.com/stem/How-plastic-is-really-recycled":
                        ["title":"How to Identify Different Types of Plastic",
                         "description":"Plastic is material consisting of any of a wide range of synthetic or semi-synthetic organic compounds that are malleable and can be molded into solid objects. Due to their low cost, ease of manufacture, versatility, and imperviousness to water, plastics are used in a multitude of products of different scale, including paper clips and spacecraft."],
                    "https://lbre.stanford.edu/pssistanford-recycling/frequently-asked-questions/frequently-asked-questions-glass-recycling":
                        ["title":"Frequently Asked Questions: Glass Recycling",
                         "description":"Glass alone makes up 5% of garbage in the U.S. It's a shame if any glass container uses up landfill space because glass lasts forever. The long-lasting nature of glass also means that glass can be recycled forever."]] as Dictionary

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        setOrder()
    }
    
    func setOrder(){
        var setLink = 0
        print(type)
        if type == "plastic"{setLink=3 }
        else if type == "miscillaneous plastic"{setLink=4 }
        else if type == "metal"{setLink=2 }
        else if type == "paper"{setLink=1 }
        else if type == "glass"{setLink=5 }
        else {print("NO TYPE FOUND")}
        
        let first = articleLinks.remove(at: setLink)
        articleLinks.insert(first, at: 0)
        
    }
    
    
    @IBAction func onSubmit(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let tabVC = main.instantiateViewController(identifier: "TabNavigationController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let delegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        delegate.window?.rootViewController = tabVC
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultCell
        
        cell.articleName.text = articles[articleLinks[indexPath.row]]!["title"]
        cell.articleDescription.text = articles[articleLinks[indexPath.row]]!["description"]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myUrl = articleLinks[indexPath.row] as! String
        let url = (URL(string: myUrl)) as! URL
        UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
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
