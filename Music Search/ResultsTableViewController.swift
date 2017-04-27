//
//  ViewController.swift
//  Music Search
//
//  Created by Marco Soto on 7/6/16.
//  Copyright © 2016 Funkadelic. All rights reserved.
//

import UIKit
import Alamofire

struct ResourceData {
    let track: String
    let artist: String
    let album: String?
    let resourceID: String
    let resourceImage: UIImage?
    let playbackURL: URL?
    let previewURL: URL?
    let external_url: URL?
    let popularity: Int
}

class ResultsTableViewController: UITableViewController {
    typealias JSONStandard = [String: AnyObject]
    
    var resourceArray = [ResourceData]()
    var itunesResources = [ResourceData]()
    var passedQuery = "Porter Robinson"

    override func viewDidLoad() {
        callAlamoforSpotify(url: generateSpotifyURL(term: passedQuery))
//        self.tableView.reloadData()
        callAlamoforiTunes(url: generateiTunesURL(term: passedQuery))
        self.tableView.reloadData()
        printURL()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceArray.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ResultTableViewCell", owner: self, options: nil)?.first as! ResultTableViewCell
        cell.mainImageView.image = resourceArray[indexPath.row].resourceImage
        cell.songLabel.text = resourceArray[indexPath.row].track
        cell.artistLabel.text = resourceArray[indexPath.row].artist
        cell.albumLabel.text = resourceArray[indexPath.row].album
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func generateSpotifyURL(term: String) -> String {
        //TODO: Sanitize spotify queries
        let sanitizedQuery = term.replacingOccurrences(of: " ", with: "+")
        let queryLimit = 10
        let queryURL = "https://api.spotify.com/v1/search?q=\(sanitizedQuery)&type=track,artist,album&limit=\(queryLimit)"
        //let testURL = "https://api.spotify.com/v1/search?q=Drake&type=track,artist,album&limit=20"
        return queryURL
    }
    
    func generateiTunesURL(term: String) -> String {
        //TODO: Sanitize itunes queries
        var sanitizedQuery = "https://itunes.apple.com/search?parameterkeyvalue"
        var searchTerm = "term=\(term)"
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let countryCodes = "country=US"
        let querySearchTypes = "mediaType=music,musicVideo,podcast"
        let returnTypes = "resultEntity=music,musicVideo,podcast"
        let queryLimit = "limit=10"
        
        sanitizedQuery = sanitizedQuery.replacingOccurrences(of: "parameterkeyvalue", with: "\(searchTerm)&\(countryCodes)&\(querySearchTypes)&\(returnTypes)&\(queryLimit)")
        print("iTunes search URL: \(sanitizedQuery)\n\n")
        return sanitizedQuery
    }
    
    //TODO: Implement Youtube Api to generate youtube search query
    func generateYouTubeURL(term: String) -> String {
        
        return ""
    }
    
    //TODO: Implement SoundCloud Api, might need to use javascript
    func generateSoundCloudURL(term: String) -> String {
        
        return ""
    }

    
    func callAlamoforSpotify(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseSpotifyData(JSONData: response.data!)
        })
    }
    
    func callAlamoforiTunes(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseiTunesData(JSONData: response.data!)
        })
    }
    
    func parseSpotifyData(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            //print(readableJSON)
            
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items  = tracks["items"] {
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        let track = item["name"] as! String
                        let artist = (item["artists"]![0] as! JSONStandard)["name"] as! String
                        let ID = item["id"] as! String
                        let resourceURL = URL(fileURLWithPath: (item["uri"] as! String))
                        
                        // Get album name and image URL for track
                        var album: String? = nil
                        var unwrappedImage: UIImage? = nil
                        if let albumField = item["album"] {
                            album = (albumField as! JSONStandard)["name"] as? String
                            let imagePool = (albumField as! JSONStandard)["images"]! //Array of returned images
                            let imageURL = URL(string: ((imagePool[0] as! JSONStandard)["url"] as! String))
                            unwrappedImage = UIImage(data: NSData(contentsOf: imageURL!) as! Data)
                        }
                        //let resourceImages = (item["album"] as! JSONStandard)["images"]!
                        //let image = (resourceImages[0] as! JSONStandard)["url"] as! String
                        //let resourceImage = URL(string: image)
                        let popularity = item["popularity"] as! Int
                        let previewURL: URL? = URL(fileURLWithPath: (item["preview_url"] as! String)) //Preview stream url
                        let externalURL: URL? = URL(fileURLWithPath: ((item["external_urls"] as! JSONStandard)["spotify"] as! String)) //Other external urls
                        
                        
                        self.resourceArray.append(ResourceData(track: track, artist: artist, album: album, resourceID: ID, resourceImage: unwrappedImage, playbackURL: resourceURL, previewURL: previewURL, external_url: externalURL, popularity: popularity))
                        self.tableView.reloadData()
                        
                    }
                }
            }
            
        }
        catch {
            print(error)
        }
    }
    
    func parseiTunesData(JSONData: Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            print(readableJSON)
            
            if let items = readableJSON["results"] {
                for i in 0..<items.count {
                    let item = items[i] as! JSONStandard
                    let track: String = item["trackName"] as! String
                    let artist: String = item["artistName"] as! String
                    var unwrappedImage: UIImage? = nil
                    if let image = item["artworkUrl100"] {
                        let imageURL = URL(string: image as! String)
                        let data = NSData(contentsOf: imageURL!) as! Data
                        unwrappedImage =  UIImage(data: data)
                    }
//                    let isStreamable = (item["isStreamable"] as! Int) == 1 ? true : false
                    let album: String? = item["collectionCensoredName"] as! String?
                    let previewURL: URL? = URL(string: item["previewUrl"] as! String)
                    let trackID = item["trackId"] as! Int
                    let trackIdAsString = String(trackID)
//                    let trackDurationInMillis = item["trackTimeMillis"] as! Int
                    let trackViewURL: URL? = URL(string: item["trackViewUrl"] as! String)
                    
                    resourceArray.append(ResourceData(track: track, artist: artist, album: album, resourceID: trackIdAsString, resourceImage: unwrappedImage, playbackURL: nil, previewURL: previewURL, external_url: trackViewURL, popularity: 0))
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    func printURL() {
        print("\n----------")
        let x = Bundle.main.debugDescription
        print(x)
        let resUrl = Bundle.allBundles
        for i in resUrl {
            print(i.debugDescription)
        }
    }
}

