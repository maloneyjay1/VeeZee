//
//  NetworkController.swift
//  MusicVideo
//
//  Created by Jay Maloney on 2/18/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class NetworkController {
    
    //change completion of dataAtURL to [Video], remove asynch from error reports, add to serialization: feed as ["feed"]jsonarray, entries as ["entry"]jsondictionary, initialize an array of Video objects in the serialization block, print index for each video with (index, video in Videos.enumerate() )
    
//    static let sharedInstance = NetworkController()
    
    func baseMusicURLForLimit(limit:Int) -> NSURL {
        let searchMod:String = "\(limit)"
        return NSURL(string: "https://itunes.apple.com/us/rss/topmusicvideos/+\(searchMod)+/json")!
    }
    
    
    func dataAtURL(url:NSURL, completion:(videos:[Video]) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do
                    {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject],
                        feed = json["feed"] as? jsonDictionary,
                        entries = feed["entry"] as? jsonArray {
                            
                            var videos = [Video]()
                            
                            for entry in entries {
                                let entry = Video(resultData: entry as! jsonDictionary)
                                videos.append(entry)
                            }
                            
                            let i = videos.count
                            print("iTunes Manager Network Call Count: \(i) Total.\n")
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    print("Success with JSON Serialization")
                                    completion(videos: videos)
                                }
                            }
                        }
                    } catch {
                        dispatch_async(dispatch_get_main_queue()) {
                            print("Failure to Serialize JSON")
                            completion(videos: [])
                        }
                    }
                }
            
        }
        dataTask.resume()
    }
}