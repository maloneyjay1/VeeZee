//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jay Maloney on 2/18/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import MediaPlayer
import MediaAccessibility

class ViewController: UIViewController {
    
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = NetworkController()
        
        let url = api.baseMusicURLForLimit(10)
        api.dataAtURL(url, completion: didLoadData)
    }
    
    func didLoadData(videos:[Video]) {
        self.videos = videos
        
        for (index, name) in videos.enumerate() {
            print("Title \(index): Name: \(name.mvName)")
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

