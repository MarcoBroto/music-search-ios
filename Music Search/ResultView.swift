//
//  ResultView.swift
//  
//
//  Created by Marco Soto on 10/3/16.
//
//

import Foundation
import UIKit

class ResultView: UIView {
    public var scale: Double
    //public var window: UIView
    public var image: UIImage?
    public var title: String
    public var artist: String?
    public var album: String?
    public var dataLimit: Double
    override
    
    // The following initializer stores the data used when initializing the view
//    override init(viewFrame: CGRect, songTitle: String, bitsUsed: Double, songArtist: String?, listedAlbum: String?, availableImage: UIImage?) {
//        //self.window = UIView(frame: viewFrame)
//        self.title = songTitle
//        self.dataLimit = bitsUsed
//        if let artist = songArtist {
//            self.artist = artist
//        }
//        if let album = listedAlbum {
//            self.album = album
//        }
//        if let image = availableImage {
//            self.image = image
//        }
        //TO-DO: call viewSetup()
//    }
    
    private func viewSetup() {
        // TO-DO: Initialize view with web results by displaying website content, add to parent scroll view
        
    }
}
