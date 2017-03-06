//
//  ViewController.swift
//  TipCalculator
//
//  Created by Tung Dang on 3/1/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let tipPercentages = [ 0.18, 0.2, 0.25]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        if (defaults.object(forKey: "defaultTip") != nil) {
            let defaultTipValue = defaults.double(forKey: "defaultTip")
            self.tipControl.selectedSegmentIndex = tipPercentages.index(of: defaultTipValue)!
        }
        if (defaults.object(forKey: "savedBill") != nil) {
            let savedBill = defaults.string(forKey: "savedBill")
            billField.text = savedBill
        }
        let start = defaults.object(forKey: "startTime") as! NSDate?
        if (start != nil) {
            print(start!)
            print(NSDate())
            let elapsedTime = NSDate().timeIntervalSince(start as! Date)
            print(elapsedTime);
            if (elapsedTime > (600)) {//elapsed time over 10 minutes
                billField.text = ""
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        self.calculateTip(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        let start = NSDate()
        defaults.removeObject(forKey: "startTime")
        defaults.set(start, forKey: "startTime")
        defaults.synchronize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func calculateTip(_ sender: Any?) {
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        defaults.set(bill, forKey: "savedBill")
        defaults.synchronize()

    }

}

