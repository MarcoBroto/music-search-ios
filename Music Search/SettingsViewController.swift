//
//  SettingsViewController.swift
//  Music Search
//
//  Created by Rafael Lopez on 11/2/16.
//  Copyright © 2016 Funkadelic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func backButton(_ sender: AnyObject) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var settingsHeader: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        settingsHeader.layer.shadowColor = UIColor.black.cgColor
        settingsHeader.layer.shadowOpacity = 1
        settingsHeader.layer.shadowOffset = CGSize.zero
        settingsHeader.layer.shadowRadius = 10
        settingsHeader.layer.shouldRasterize = true
        
    }

}
