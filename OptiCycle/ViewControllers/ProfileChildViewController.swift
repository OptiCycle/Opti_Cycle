//
//  ProfileChildViewController.swift
//  OptiCycle
//
//  Created by Mikael Joseph Kaufman on 4/2/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileChildViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var editProfilePenImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    enum ImageCastError: Error {
        case failed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.layer.borderWidth = 3.0
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        
        editProfilePenImage.layer.masksToBounds = false
        editProfilePenImage.layer.cornerRadius = editProfilePenImage.frame.height/2
        editProfilePenImage.layer.borderWidth = 2.0
        editProfilePenImage.clipsToBounds = true
        editProfilePenImage.layer.borderColor = UIColor.black.cgColor
    
    }
    
    //Everytime View appears, do this
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentUser = PFUser.current()?.object(forKey: "username")
        usernameLabel.text = currentUser as? String
        
        if let imageFile: PFFileObject = PFUser.current()?.value(forKey: "profileImage") as? PFFileObject {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {

                        let image = UIImage(data: data!)
//                        let size = CGSize(width: 300, height: 300)
//                        let scaledImage = image!.af_imageAspectScaled(toFill: size)
                        self.profileImage.image = image
                    }
                }
            })
        }
    }
    
    
    @IBAction func onProfileImage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Change Profile Photo?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("Cancelled")
        }))
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action) in
            
            self.afterPopup(popup: alert.title!)
            
            // Store Image selected as User's profile to Parse database
            let currentUser = PFUser.current()
            
            if currentUser != nil {
                let imageData = self.profileImage.image!.pngData()
                let file = PFFileObject(data: imageData!)
                currentUser?["profileImage"] = file
                
                currentUser?.saveInBackground{ (success, error) in
                    if success {
//                        self.dismiss(animated: true, completion: nil)
                        print("Saved photo taken!")
                    } else {
                        print("error!")
                    }
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (action) in
            
            self.afterPopup(popup: alert.title!)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Remove Current Photo", style: .default, handler: { (action) in
            
            self.profileImage.image = UIImage(systemName: "person.crop.circle.fill")
            
            // Store Image selected as User's profile to Parse database
            let currentUser = PFUser.current()
            
            if currentUser != nil {
                let imageData = self.profileImage.image!.pngData()
                let file = PFFileObject(data: imageData!)
                currentUser?["profileImage"] = file
                
                currentUser?.saveInBackground{ (success, error) in
                    if success {
//                        self.dismiss(animated: true, completion: nil)
                        print("Current Photo Removed!")
                    } else {
                        print("error!")
                    }
                }
            }
            
        }))
        
        //Shows alert
        self.present(alert, animated: true)

        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        
        // Store Image selected as User's profile to Parse database
        let currentUser = PFUser.current()
        
        if currentUser != nil {
            let imageData = self.profileImage.image!.pngData()
            let file = PFFileObject(data: imageData!)
            currentUser?["profileImage"] = file
            
            currentUser?.saveInBackground{ (success, error) in
                if success {
//                    self.dismiss(animated: true, completion: nil)
                    print("Saved photo chosen!")
                } else {
                    print("error!")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func afterPopup(popup: String) {
        if popup == "Take Photo" {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                print("No Camera!")
            }
            
        } else {
            // User picked "Choose from Library"
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true

            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
}
