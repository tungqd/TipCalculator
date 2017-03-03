//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Tung Dang on 3/1/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    let defaultTips = [0.18, 0.2, 0.25]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "defaultTip") != nil) {
            let defaultTipValue = defaults.double(forKey: "defaultTip")
            self.defaultTipControl.selectedSegmentIndex = defaultTips.index(of: defaultTipValue)!
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveDefaultTip(_ sender: Any) {
        
        let selectedValue = defaultTips[defaultTipControl.selectedSegmentIndex]
        let defaults = UserDefaults.standard
        defaults.set(selectedValue, forKey: "defaultTip")
        defaults.synchronize()
    }
}
