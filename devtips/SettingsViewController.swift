//
//  SettingsViewController.swift
//  devtips
//
//  Created by Julia Yu on 2/8/16.
//  Copyright © 2016 julia yu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var PercentSegment: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        let defaultTip = defaults.integerForKey("defaultTip")
        PercentSegment.selectedSegmentIndex = defaultTip
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onPercentChange(sender: AnyObject) {

        let tip = PercentSegment.selectedSegmentIndex
        
        defaults.setObject(tip, forKey: "defaultTip")
        defaults.synchronize()
    }
}
