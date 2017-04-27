//
//  SearchViewController.swift
//  Music Search
//
//  Created by Marco Soto on 2/14/17.
//  Copyright © 2017 Funkadelic. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var searchSettings = [String:Bool]()
    
    @IBOutlet weak var searchBar: UITextField!
    
    override func viewDidLoad() {
        searchBar.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        print("Searched")
        performSegue(withIdentifier: "showResultsView", sender: self)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetController = segue.destination as? ResultsTableViewController
        if let query = self.searchBar.text {
            if let target = targetController {
                target.passedQuery = query
            }
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Done editing")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        var targetController = segue.destination as! ResultsTableViewController
//        if let query = self.searchBar.text {
//            targetController.passedQuery = query
//        }
//    }

}
