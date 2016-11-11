//
//  HomeViewController.swift
//  Music Search
//
//  Created by Rafael Lopez on 11/2/16.
//  Copyright © 2016 Funkadelic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeHeader: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        homeHeader.layer.shadowColor = UIColor.black.cgColor
        homeHeader.layer.shadowOpacity = 1
        homeHeader.layer.shadowOffset = CGSize.zero
        homeHeader.layer.shadowRadius = 10
        homeHeader.layer.shouldRasterize = true
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
