//
//  ViewController.swift
//  Music Search
//
//  Created by Marco Soto on 7/6/16.
//  Copyright © 2016 Funkadelic. All rights reserved.
//

import UIKit

struct CellData {
    var song: String!
    var artist: String!
    var album: String!
    var image: UIImage!
}

class ResultsTableViewController: UITableViewController {
    
    var resultsData = [CellData]()

    override func viewDidLoad() {
        resultsData = [CellData(song: "Song", artist: "Artist", album:"Album", image: #imageLiteral(resourceName: "ImagePlaceholder"))]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ResultTableViewCell", owner: self, options: nil)?.first as! ResultTableViewCell
        cell.mainImageView.image = resultsData[indexPath.row].image
        cell.songLabel.text = resultsData[indexPath.row].song
        cell.artistLabel.text = resultsData[indexPath.row].artist
        cell.albumlLabel.text = resultsData[indexPath.row].album
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }

}

