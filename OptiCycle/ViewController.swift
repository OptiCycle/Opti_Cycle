//
//  ViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 3/25/21.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.5, animations: {
//            let size = self.view.frame.size.width * 3
//            let diffX = size - self.view.frame.size.width
//            let diffY = self.view.frame.size.height - size
//
//            self.logoImageView.frame = CGRect(
//                x: -(diffX/2),
//                y: diffY/2,
//                width: size,
//                height: size
//            )
            
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.7, animations: {
                    self.logoImageView.transform = CGAffineTransform(scaleX: 20,y: 20)
                    self.logoImageView.alpha = 0
                })
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8, execute: {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
            loginVC!.modalTransitionStyle = .crossDissolve
            loginVC!.modalPresentationStyle = .fullScreen
            self.present(loginVC!, animated: true, completion: nil)
        })
    }
    


}

