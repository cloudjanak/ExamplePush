//
//  ViewController.swift
//  Example
//
//  Created by ShuZik on 31.10.15.
//  Copyright © 2015 ShuZik. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var deviceTokenLabel: UILabel!
    @IBOutlet weak var pushTextField: UITextView!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("setDeviceToken"), name: NSUserDefaultsDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("setPushText"), name: NSUserDefaultsDidChangeNotification, object: nil)
    }
    
    func setDeviceToken()
    {
        if let deviceToken = userDefaults.valueForKey("DeviceToken") {
            deviceTokenLabel.font = UIFont (name: "Helvetica Neue", size: 9)
            deviceTokenLabel.text = String(deviceToken)
        } else {
            deviceTokenLabel.text = "Ошибка генерации DeviceToken"
        }
    }
    
    func setPushText()
    {
        if let pushText = userDefaults.valueForKey("PushText") {
            pushTextField.text = pushText as! String
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSUserDefaultsDidChangeNotification, object: nil)
    }
}

