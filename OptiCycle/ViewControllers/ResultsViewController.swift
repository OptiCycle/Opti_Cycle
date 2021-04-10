//
//  ResultsViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/10/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var revealLabel: UILabel!
    @IBOutlet weak var disposeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
