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
        
        UIView.animateWithDuration(0.3,
            animations:  {() in
                self.billPanel.frame.origin.y = 30
            },
            completion:{(Bool) in
                
                UIView.animateWithDuration(0.3, animations: {
                    self.tipPanel.frame.origin.x = 0
                    self.totalPanel.frame.origin.x = 0
                })
            }
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        totalPanel.frame.origin.x = -320
        tipPanel.frame.origin.x = 320
        billPanel.frame.origin.y = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billInput.becomeFirstResponder()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func onEditBegin(sender: AnyObject) {
        clearOutputs()
    }
    
    @IBAction func onEditEnd(sender: AnyObject) {
        showOutputs()
    }

    @IBAction func onEdit(sender: AnyObject) {
        let tipPercent = [0.18, 0.2, 0.22]
        let bill = NSString(string: billInput.text!).doubleValue
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = tip + bill
        let t2 = total/2
        let t3 = total/3
        
        tipOutput.text = String(format: "$%.2f", tip)
        total1.text = String(format: "$%.2f", total)
        total2.text = String(format: "$%.2f", t2)
        total3.text = String(format: "$%.2f", t3)
    }
    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

