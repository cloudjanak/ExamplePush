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
    @IBOutlet weak var copyDeviceTokenView: UILabel!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("setDeviceToken"), name: NSUserDefaultsDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("setPushText"), name: NSUserDefaultsDidChangeNotification, object: nil)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "testCopy:")
        deviceTokenLabel.addGestureRecognizer(longPressRecognizer)
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
    
    func testCopy(sender: UILongPressGestureRecognizer)
    {
        let pboard : UIPasteboard = UIPasteboard.generalPasteboard()
        pboard.string = deviceTokenLabel.text;
        copyDeviceTokenView.hidden = false
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "hideDeviceTokenView", userInfo: nil, repeats: false)
    }
    
    func hideDeviceTokenView()
    {
        UIView.animateWithDuration(0.4, animations: {
            self.copyDeviceTokenView.alpha = 0
        }, completion: { (value: Bool) in
            self.copyDeviceTokenView.hidden = true
            self.copyDeviceTokenView.alpha = 1
        })
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

