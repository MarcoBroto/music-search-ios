//
//  ViewController.swift
//  Music Search
//
//  Created by Marco Soto on 7/6/16.
//  Copyright © 2016 Funkadelic. All rights reserved.
//

import UIKit
import Alamofire

struct CellData {
    var song: String
    var artist: String
    var album: String
    var image: UIImage
}

struct ResourceData {
    var resourceName: String
    var resourceID: String
    var resourceImageURL: URL?
    var playURL: URL?
    var previewURL: URL?
    var external_url: URL
    var popularity: Int
}

class ResultsTableViewController: UITableViewController {
    typealias JSONStandard = [String: AnyObject]
    
    var resultsData = [CellData]()
    var resourceArray = [ResourceData]()

    override func viewDidLoad() {
        callAlamo(url: generateURL(query: "Drake"))
        resultsData = [CellData(song: "Thief", artist: "Ookay", album:"N/A", image: #imageLiteral(resourceName: "ImagePlaceholder")),
        CellData(song: "Wicked", artist: "Griz", album:"Good Times Roll", image: #imageLiteral(resourceName: "ImagePlaceholder")),
        CellData(song: "Hotline Bling", artist: "Drake", album:"Views", image: #imageLiteral(resourceName: "ImagePlaceholder"))]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsData.count
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ResultTableViewCell", owner: self, options: nil)?.first as! ResultTableViewCell
        cell.mainImageView.image = resultsData[indexPath.row].image
        cell.songLabel.text = resultsData[indexPath.row].song
        cell.artistLabel.text = resultsData[indexPath.row].artist
        cell.albumLabel.text = resultsData[indexPath.row].album
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func generateURL(query: String) -> String {
//        let queryLimit = 20
//        let queryURL:URL = URL(fileURLWithPath: "https://api.spotify.com/v1/search?q=\(query)&type=track,artist,album&limit=\(queryLimit)")
        let q = "https://api.spotify.com/v1/search?q=Drake&type=track,artist,album&limit=20"
        return q
    }
    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            print(readableJSON)
            
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items  = tracks["items"] {
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        
                        let resourceName = item["name"] as! String
                        let ID = item["id"] as! String
                        let resourceURL = URL(fileURLWithPath: (item["uri"] as! String))
                        
                        var resourceImage: URL?
                        if let imagesArray = item["images"] {
                            resourceImage = URL(fileURLWithPath: ((imagesArray[0] as! JSONStandard)["url"] as! String))
                            print(resourceImage)
                        }
                        
                        let resourcePopularity = item["popularity"] as! Int
                        let previewURL = URL(fileURLWithPath: (item["preview_url"] as! String))
                        let externalURL = URL(fileURLWithPath: ((item["external_urls"] as! JSONStandard)["spotify"] as! String))
                        
                        self.resourceArray.append(ResourceData(resourceName: resourceName, resourceID: ID, resourceImageURL: resourceImage, playURL: resourceURL, previewURL: previewURL, external_url: externalURL, popularity: resourcePopularity))
                        print(resourceName)
                        print(resourceURL)
                        print(resourcePopularity)
                        print(previewURL)
                        print(externalURL)
                        if resourceImage == nil {
                            print("No image returned")
                        }
                    }
                }
            }
            
        }
        catch {
            print(error)
        }
    }
}

