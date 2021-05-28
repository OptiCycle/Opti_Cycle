//
//  InferenceViewController.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/8/21.
//


import UIKit
import Parse

// MARK: InferenceViewControllerDelegate Method Declarations
protocol InferenceViewControllerDelegate {

  /**
   This method is called when the user changes the stepper value to update number of threads used for inference.
   */
  func didChangeThreadCount(to count: Int)

}

class InferenceViewController: UIViewController {

  // MARK: Sections and Information to display
  private enum InferenceSections: Int, CaseIterable {
    case Results
    case InferenceInfo
  }

  private enum InferenceInfo: Int, CaseIterable {
    case Resolution
    case Crop
    case InferenceTime

    func displayString() -> String {

      var toReturn = ""

      switch self {
      case .Resolution:
        toReturn = "Resolution"
      case .Crop:
        toReturn = "Crop"
      case .InferenceTime:
        toReturn = "Inference Time"

      }
      return toReturn
    }
  }

  // MARK: Storyboard Outlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: Constants
  private let normalCellHeight: CGFloat = 27.0
  private let separatorCellHeight: CGFloat = 42.0
  private let bottomSpacing: CGFloat = 21.0
  private let minThreadCount = 1
  private let bottomSheetButtonDisplayHeight: CGFloat = 44.0
  private let lightTextInfoColor = UIColor(displayP3Red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
  private let infoFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
  private let highlightedFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)

  // MARK: Instance Variables
  var inferenceResult: Result? = nil
  var wantedInputWidth: Int = 0
  var wantedInputHeight: Int = 0
  var resolution: CGSize = CGSize.zero
  var maxResults: Int = 0
  var threadCountLimit: Int = 0
  private var currentThreadCount: Int = 0
  private var infoTextColor = UIColor.black
    

  // MARK: Delegate
  var delegate: InferenceViewControllerDelegate?

  // MARK: Computed properties
  var collapsedHeight: CGFloat {
    return normalCellHeight * CGFloat(maxResults - 1) + separatorCellHeight + bottomSheetButtonDisplayHeight

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the info text color on iOS 11 and higher.
    if #available(iOS 11, *) {
        infoTextColor = lightTextInfoColor
    }
    
  }

  // MARK: Buttion Actions
  /**
   Delegate the change of number of threads to View Controller and change the stepper display.
   */
    
    @IBAction func onRecycleButton(_ sender: Any) {
        let user = PFUser.current() as! PFUser
        let post = PFObject(className: "Posts")
        
        post["author"] = PFUser.current()
        let tuple = displayStringsForResults(atRow: 0)
        let item = tuple.0
        let confidence = tuple.1
        if item.count == 0{
            print("No item found")
            self.dismiss(animated: true, completion: nil)
            return
        }
        post["item"] = item
        
        // Increment User's type of trash count
        user.incrementKey(item, byAmount: 1)
        user.incrementKey("totalPosts", byAmount: 1)
        checkIfUserGotBadge(currentUser: PFUser.current()!)
        user.saveInBackground
        {(success, error) in
            if success{
                print("Successfully Incremented \(user.username)'s Recycle Count")
            }
            else{
                print("error: \(error?.localizedDescription)")
            }
        }
        // End of increment
        
        post["confidence"] = confidence
        let imageName = getImageLabel(item: item)
        post["image_label"] = imageName
        
        post.saveInBackground()
        {(success, error) in
            if success{
                let main = UIStoryboard(name: "Main", bundle: nil)
                let resultsVC = main.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let delegate = windowScene.delegate as? SceneDelegate
                  else {
                    return
                  }
                
                delegate.window?.rootViewController = resultsVC
                resultsVC.typeImage.image = UIImage(named: imageName) as! UIImage
                resultsVC.revealLabel.text = "This is \(item)"
                resultsVC.disposeLabel.text = "Dispose in the \(item) bin"
                self.dismiss(animated: true, completion: nil)
                 
                print("saved")
            }
            else{
                print("error: \(error?.localizedDescription)")
            }
        }
    }
    
    // Start of Check for Badge
    func checkIfUserGotBadge(currentUser: PFUser) {
        let query = PFQuery(className:"Badges")
        query.whereKey("author", equalTo: currentUser)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print("\(error.localizedDescription)")
            } else if let objects = objects {
                // The find succeeded.
                // Do something with the found objects
                for object in objects {
                    if (object["badgeCount"] as! Int) != 12 {
                        let glass = currentUser["glass"] as! Int
                        let plastic = currentUser["plastic"] as! Int
                        let metal = currentUser["metal"] as! Int
                        let paper = currentUser["paper"] as! Int
                        let posts = currentUser["totalPosts"] as! Int
                        
                        // Conditions for badge 1, 2, 3
                        if posts < 500{
                            if (object["badge1"] as! Bool == false) && posts >= 50 {
                                object["badge1"] = true
                                object.incrementKey("badgeCount", byAmount: 1)
                            }
                            if (object["badge2"] as! Bool == false) && posts >= 200 {
                                object["badge2"] = true
                                object.incrementKey("badgeCount", byAmount: 1)
                            }
                            if (object["badge3"] as! Bool == false) && posts >= 500 {
                                object["badge3"] = true
                                object.incrementKey("badgeCount", byAmount: 1)
                            }
                        }
                        // End of conditions 1, 2, 3
                        
                        // Conditions for badge 4, 5, 6
                        if (object["badge4"] as! Bool == false) && (glass >= 50) && (metal >= 50) && (plastic >= 50) && (paper >= 50){
                            object["badge4"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge5"] as! Bool == false) && (glass >= 250) && (metal >= 250) && (plastic >= 250) && (paper >= 250){
                            object["badge5"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge6"] as! Bool == false) && (glass >= 500) && (metal >= 500) && (plastic >= 500) && (paper >= 500){
                            object["badge6"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        // End of Conditions 4, 5, 6
                        
                        if (object["badge7"] as! Bool == false) && plastic >= 100 {
                            object["badge7"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge8"] as! Bool == false) && glass >= 100 {
                            object["badge8"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge9"] as! Bool == false) && metal >= 100 {
                            object["badge9"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge10"] as! Bool == false) && paper >= 100 {
                            object["badge10"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge11"] as! Bool == false) && posts >= 1 {
                            object["badge11"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                        if (object["badge12"] as! Bool == false) && (object["badgeCount"] as! Int) == 11 {
                            object["badge12"] = true
                            object.incrementKey("badgeCount", byAmount: 1)
                        }
                    }
                    object.saveInBackground()
                }
            }
        }
    } // End of Check for Badge
    
    func getImageLabel(item: String) -> String{
        
//        let plasticLabels = ["water bottle", "water jug"]
//        let metalLabels = ["beer bottle", "pop bottle"]
//        let electronicsLabels = ["remote control"]
//        let glassLabels = ["wine bottle"]
        
        if item == "plastic"{
            return "plastics"
        }
        else if item == "metal"{
            return "metals"
        }
        else if item == "miscellaneous plastic"{
            return "plastics"
        }
        else{
            return item
        }
        
    }
    
}

// MARK: UITableView Data Source
extension InferenceViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {

    return InferenceSections.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    guard let inferenceSection = InferenceSections(rawValue: section) else {
      return 0
    }

    var rowCount = 0
    switch inferenceSection {
    case .Results:
      rowCount = maxResults
    case .InferenceInfo:
      rowCount = InferenceInfo.allCases.count
    }
    return rowCount
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    var height: CGFloat = 0.0

    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
      return height
    }

    switch inferenceSection {
    case .Results:
      if indexPath.row == maxResults - 1 {
        height = separatorCellHeight + bottomSpacing
      }
      else {
        height = normalCellHeight
      }
    case .InferenceInfo:
      if indexPath.row == InferenceInfo.allCases.count - 1 {
        height = separatorCellHeight + bottomSpacing
      }
      else {
        height = normalCellHeight
      }
    }
    return height
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell

    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
      return cell
    }

    var fieldName = ""
    var info = ""
    var font = infoFont
    var color = infoTextColor

    switch inferenceSection {
    case .Results:

      let tuple = displayStringsForResults(atRow: indexPath.row)
      fieldName = tuple.0
      info = tuple.1

      if indexPath.row == 0 {
        font = highlightedFont
        color = infoTextColor
      }
      else {
        font = infoFont
        color = lightTextInfoColor
      }

    case .InferenceInfo:
      let tuple = displayStringsForInferenceInfo(atRow: indexPath.row)
      fieldName = tuple.0
      info = tuple.1

    }
    cell.fieldNameLabel.font = font
    cell.fieldNameLabel.textColor = color
    cell.fieldNameLabel.text = fieldName
    cell.infoLabel.text = info
    return cell
  }

  // MARK: Format Display of information in the bottom sheet
  /**
   This method formats the display of the inferences for the current frame.
   */
  func displayStringsForResults(atRow row: Int) -> (String, String) {

    var fieldName: String = ""
    var info: String = ""

    guard let tempResult = inferenceResult, tempResult.inferences.count > 0 else {

      if row == 1 {
        fieldName = "No Results"
        info = ""
      }
      else {
        fieldName = ""
        info = ""
      }
      return (fieldName, info)
    }

    if row < tempResult.inferences.count {
      let inference = tempResult.inferences[row]
      fieldName = inference.label
      info =  String(format: "%.2f", inference.confidence * 100.0) + "%"
    }
    else {
      fieldName = ""
      info = ""
    }

    return (fieldName, info)
  }

  /**
   This method formats the display of additional information relating to the inferences.
   */
  func displayStringsForInferenceInfo(atRow row: Int) -> (String, String) {

    var fieldName: String = ""
    var info: String = ""

    guard let inferenceInfo = InferenceInfo(rawValue: row) else {
      return (fieldName, info)
    }

    fieldName = inferenceInfo.displayString()

    switch inferenceInfo {
    case .Resolution:
      info = "\(Int(resolution.width))x\(Int(resolution.height))"
    case .Crop:
      info = "\(wantedInputWidth)x\(wantedInputHeight)"
    case .InferenceTime:
      guard let finalResults = inferenceResult else {
        info = "0ms"
        break
      }
      info = String(format: "%.2fms", finalResults.inferenceTime)
    }

    return(fieldName, info)
  }
    
}


