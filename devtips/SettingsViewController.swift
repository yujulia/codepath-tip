//
//  SettingsViewController.swift
//  devtips
//
//  Created by Julia Yu on 2/8/16.
//  Copyright © 2016 julia yu. All rights reserved.
//

import UIKit

struct Style {
    static func pinku() {
        
    }
    
    static func sax() {
        
    }
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var PercentSegment: UISegmentedControl!
    @IBOutlet weak var ThemeSegment: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set default segments
        
        ThemeSegment.selectedSegmentIndex = 1
        PercentSegment.selectedSegmentIndex = 1
        
        // if some segment has been choosen load those
        
        if (defaults.objectForKey("defaultTip") != nil) {
            PercentSegment.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        }
        
        if (defaults.objectForKey("theme") != nil) {
            ThemeSegment.selectedSegmentIndex = defaults.integerForKey("theme")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onThemeChange(sender: UISegmentedControl) {
        let theme = ThemeSegment.selectedSegmentIndex
        
        defaults.setObject(theme, forKey: "theme")
        defaults.synchronize()
    }
    
    @IBAction func onPercentChange(sender: AnyObject) {

        let tip = PercentSegment.selectedSegmentIndex
        
        defaults.setObject(tip, forKey: "defaultTip")
        defaults.synchronize()
    }
}
