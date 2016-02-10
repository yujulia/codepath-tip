//
//  ViewController.swift
//  devtips
//
//  Created by Julia Yu on 2/7/16.
//  Copyright © 2016 julia yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billInput: UITextField!
    @IBOutlet weak var tipOutput: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var total1: UILabel!
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var total3: UILabel!
    @IBOutlet weak var totalPanel: UIView!
    @IBOutlet weak var tipPanel: UIView!
    @IBOutlet weak var billPanel: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    let resetSeconds = 60
    
    var width: CGFloat!
    var center: CGFloat!
    var billTop: CGFloat!
    var billMiddle: CGFloat!
    
    func changeColors(bgColor: UIColor, fgColor: UIColor) {
        self.view.backgroundColor = bgColor
        self.view.tintColor = fgColor
        navigationController?.navigationBar.barTintColor = fgColor
        navigationController?.navigationBar.tintColor = bgColor
        self.billInput.tintColor = fgColor
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
    
    func beginInput() {
        UIView.animateWithDuration(0.5,
            animations:  {() in
                self.billPanel.frame.origin.y = self.billMiddle
            }
        )
    }
    
    func endInput() {
        UIView.animateWithDuration(0.5,
            animations:  {() in
                self.billPanel.frame.origin.y = self.billTop
            }
        )
    }
    
    func clearOutputs() {
        tipOutput.text = "$0"
        total1.text = "$0"
        total2.text = "$0"
        total3.text = "$0"
        
        UIView.animateWithDuration(0.5,
            animations:  {() in
                self.tipPanel.frame.origin.x = self.width
                self.totalPanel.frame.origin.x = -1 * self.width
                self.tipPanel.alpha = 0
            }
        )
    }

    func showOutputs() {
        UIView.animateWithDuration(0.5,
            animations: {() in
                self.tipPanel.center.x = self.center
                self.totalPanel.center.x = self.center
                self.tipPanel.alpha = 1
            }
        )
    }
    
    // do tip calculations and update output labels
    //
    func updateOutputs() {
        let tipPercent = [0.18, 0.2, 0.22]
        let bill = NSString(string: billInput.text!).doubleValue
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = tip + bill
        let t2 = total/2
        let t3 = total/3
        
        tipOutput.text = formatter.stringFromNumber(tip)
        total1.text = formatter.stringFromNumber(total)
        total2.text = formatter.stringFromNumber(t2)
        total3.text = formatter.stringFromNumber(t3)
        
        // save bill amount & time it was saved
        
        let timestamp = NSDate()
        defaults.setObject(String(format: "%.2f", bill), forKey: "defaultBill")
        defaults.setObject(timestamp, forKey: "defaultBillChanged")
        defaults.synchronize()
    }
    
    //--------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check default amount expire
        let lastTime = defaults.objectForKey("defaultBillChanged") as! NSDate
        let thisTime = NSDate()
        let elapsed = Int(thisTime .timeIntervalSinceDate(lastTime))
    
        if (elapsed > resetSeconds) {
            defaults.setObject("", forKey: "defaultBill")
            defaults.synchronize()
        }
        
        // calculate animation offsets
        
        let bounds = UIScreen.mainScreen().bounds
        self.width = bounds.size.width
        self.billTop = CGFloat(70)
        self.billMiddle = bounds.size.height/2 - self.billPanel.bounds.size.height
        self.center = width / 2
        
        // move panels to initial position
        
        totalPanel.frame.origin.x = -1 * self.width
        tipPanel.frame.origin.x = self.width
        billPanel.frame.origin.y = self.billTop
        
        // if we have a saved value for bill amount and its none empty and we have no previous input...
        
        let defaultBill = defaults.stringForKey("defaultBill")
        if (defaultBill != "" && defaultBill != "0.00" && billInput.text == "") {
            self.billInput.text = defaultBill
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        switchTheme(self.defaults.objectForKey("themeName") as! String)
        
        // set number formatter for locale
        
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        formatter.groupingSeparator = ","
        
        // update placeholder
        
        let str = NSAttributedString(string: formatter.currencySymbol, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        billInput.attributedPlaceholder = str
        
        // if default tip changed, recalculate with that tip percent
        
        let defaultTip = defaults.integerForKey("defaultTip")
        if (tipControl.selectedSegmentIndex != defaultTip) {
            tipControl.selectedSegmentIndex = defaultTip
            updateOutputs()
        }
        
        clearOutputs()
        beginInput()
        billInput.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditBegin(sender: AnyObject) {
        beginInput()
        clearOutputs()
    }
    
    @IBAction func onEditEnd(sender: AnyObject) {
        let bill = NSString(string: self.billInput.text!)
        if (bill == "") {
            return // we have no input, do nothing
        }
        
        updateOutputs()
        endInput()
        showOutputs()
    }

    @IBAction func onEdit(sender: AnyObject) {
        updateOutputs()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

