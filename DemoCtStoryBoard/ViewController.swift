//
//  ViewController.swift
//  DemoCtStoryBoard
//
//  Created by Prajwal Jagadeesh on 07/01/24.
//

import UIKit
import CleverTapSDK
import OSLog

class ViewController: UIViewController ,CleverTapDisplayUnitDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
    }

    @IBAction func onUserLogin(_ sender: Any) {
        let profile: Dictionary<String, String> = [
            //Update pre-defined profile properties
            "Name": "iOS Profile",
            "Email": "iosprofile@gmail.com",
            //Update custom profile properties
            "Plan type": "Silver",
            "Favorite Food": "Pizza"
        ]

        CleverTap.sharedInstance()?.onUserLogin(profile)
    }
    
    @IBAction func AddEvent(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Product viewed")
    }
    
    
    
    @IBAction func AddSingleImagePush(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("Single Image Push")
    }
    @IBAction func PushTemplate(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent("PushTemplate")
    }
    
    
    @IBAction func AddEventWithProperties(_ sender: Any) {
        let props = [
            "Product name": "Casio Chronograph Watch",
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ] as [String : Any]

        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
    }
    
    
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
           // you will get display units here
        var units:[CleverTapDisplayUnit] = displayUnits;
        
        let logger = Logger()
        
        var unitsString:String = (units[0].contents?.first?.message)! as String
    
        logger.info("NativeDisplay Units \(unitsString)")
    
        self.showToast(message: "Native Display First Content ---> \(unitsString)", seconds: 10.0)
        
        
    }
    
    
}

extension UIViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }

