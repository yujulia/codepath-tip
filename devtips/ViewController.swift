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
    var firstLoad = false;
    
    func clearOutputs() {
        tipOutput.text = "$0"
        total1.text = "$0"
        total2.text = "$0"
        total3.text = "$0"
        
        UIView.animateWithDuration(0.3, animations:  {() in
            self.tipPanel.frame.origin.x = 320
            self.totalPanel.frame.origin.x = -320
            }, completion:{(Bool)  in
                UIView.animateWithDuration(0.3, animations: {
                    self.billPanel.frame.origin.y = 200
                })
        })
    }
    
    func showOutputs() {
        let bill = NSString(string: self.billInput.text!)
        
        if (bill == "") {
            return
        }
        
        if (firstLoad) {
            firstLoad = false;
        } else {
            UIView.animateWithDuration(0.3,
                animations:  {() in
                    self.billPanel.frame.origin.y = 70
                },
                completion:{(Bool) in
                    
                    UIView.animateWithDuration(0.3, animations: {
                        self.tipPanel.frame.origin.x = 0
                        self.totalPanel.frame.origin.x = 0
                    })
                }
            )
        }
    }
    
    func updateOutputs() {
        let tipPercent = [0.18, 0.2, 0.22]
        let bill = NSString(string: billInput.text!).doubleValue
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = tip + bill
        let t2 = total/2
        let t3 = total/3
        
        defaults.setObject(String(format: "%.2f", bill), forKey: "defaultBill")
        defaults.synchronize()
    
        tipOutput.text = formatter.stringFromNumber(tip)
        total1.text = formatter.stringFromNumber(total)
        total2.text = formatter.stringFromNumber(t2)
        total3.text = formatter.stringFromNumber(t3)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        totalPanel.frame.origin.x = -320
        tipPanel.frame.origin.x = 320
        billPanel.frame.origin.y = 70
        
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        billInput.placeholder = formatter.currencySymbol
    
        let defaultTip = defaults.integerForKey("defaultTip")

        if (tipControl.selectedSegmentIndex != defaultTip) {
            tipControl.selectedSegmentIndex = defaultTip
            updateOutputs()
        }
        
        showOutputs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billInput.becomeFirstResponder()

        let defaultBill = defaults.stringForKey("defaultBill")
        
        if (defaultBill != "" && defaultBill != "0.00" && billInput.text == "") {
            self.billInput.text = defaultBill
            firstLoad = true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditBegin(sender: AnyObject) {
        clearOutputs()
        updateOutputs()
    }
    
    @IBAction func onEditEnd(sender: AnyObject) {
        showOutputs()
    }

    @IBAction func onEdit(sender: AnyObject) {
        updateOutputs()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

