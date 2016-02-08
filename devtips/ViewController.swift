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
    
    func clearOutputs() {
        tipOutput.text = ""
        total1.text = ""
        total2.text = ""
        total3.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        clearOutputs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billInput.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onEditBegin(sender: AnyObject) {
        
    }

    @IBAction func onEdit(sender: AnyObject) {
        let tipPercent = [0.18, 0.2, 0.22]
        let bill = NSString(string: billInput.text!).doubleValue
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = tip + bill
        let t2 = total/2
        let t3 = total/3
        
        if (billInput.text == "") {
            clearOutputs()
        } else {

        }
        
        tipOutput.text = String(format: "$%.2f", tip)
        total1.text = String(format: "$%.2f", total)
        total2.text = String(format: "$%.2f", t2)
        total3.text = String(format: "$%.2f", t3)
    }
    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

