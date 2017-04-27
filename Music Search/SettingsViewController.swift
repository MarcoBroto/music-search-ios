//
//  SettingsViewController.swift
//  Music Search
//
//  Created by Marco Soto on 2/21/17.
//  Copyright © 2017 Funkadelic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBAction func dismissSettingsView(_ sender: UIBarButtonItem) {
        print("Dismissed")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
