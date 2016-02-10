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
    @IBOutlet weak var ThemeSegment: UISegmentedControl!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let themes = ["pinku", "sax", "black"]
    
    func changeColors(bgColor: UIColor, fgColor: UIColor) {
        self.view.backgroundColor = bgColor
        self.view.tintColor = fgColor
        percentLabel.textColor = fgColor
        themeLabel.textColor = fgColor
        navigationController?.navigationBar.barTintColor = fgColor
        navigationController?.navigationBar.tintColor = bgColor
    }
    
    func switchTheme(themeName: String) {
        let pinkuColor = UIColor(red: 232.0/255, green: 101.0/255, blue: 209.0/255, alpha: 1.0)
        let saxColor = UIColor(red: 166.0/255, green: 181.0/255, blue: 190.0/255, alpha: 1.0)
        
        switch themeName {
            case "pinku":
                changeColors(pinkuColor, fgColor: UIColor.whiteColor())
            case "black":
                changeColors(UIColor.blackColor(), fgColor: UIColor.whiteColor())
            default:
                changeColors(saxColor, fgColor: UIColor.whiteColor())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set default segments
        
        ThemeSegment.selectedSegmentIndex = 1
        PercentSegment.selectedSegmentIndex = 1
        
        // if some segment has been choosen load those
        
        if (self.defaults.objectForKey("defaultTip") != nil) {
            PercentSegment.selectedSegmentIndex = self.defaults.integerForKey("defaultTip")
        }
        
        if (self.defaults.objectForKey("theme") != nil) {
            ThemeSegment.selectedSegmentIndex = self.defaults.integerForKey("theme")
        }
        
        switchTheme(self.defaults.objectForKey("themeName") as! String)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onThemeChange(sender: UISegmentedControl) {
        let theme = ThemeSegment.selectedSegmentIndex
        
        self.defaults.setObject(theme, forKey: "theme")
        self.defaults.setObject(self.themes[theme], forKey: "themeName")
        self.defaults.synchronize()
        
        switchTheme(self.themes[theme])
    }
    
    @IBAction func onPercentChange(sender: AnyObject) {

        let tip = PercentSegment.selectedSegmentIndex
        
        self.defaults.setObject(tip, forKey: "defaultTip")
        self.defaults.synchronize()
    }
}
