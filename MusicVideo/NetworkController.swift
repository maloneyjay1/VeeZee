//
//  NetworkController.swift
//  MusicVideo
//
//  Created by Jay Maloney on 2/18/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let sharedInstance = NetworkController()
    
    static func baseMusicURLForLimit(limit:Int) -> NSURL {
        let searchMod:String = "\(limit)"
        return NSURL(string: "https://itunes.apple.com/us/rss/topmusicvideos/+\(searchMod)+/json")!
    }
    
    static func dataAtURL(url:NSURL, completion:(resultData:NSData?) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do
                    {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject] {
                            
                            print(json)
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    print("Success with JSON Serialization")
                                    completion(resultData: data)
                                }
                            }
                        }
                    } catch {
                        dispatch_async(dispatch_get_main_queue()) {
                            print("Failure to Serialize JSON")
                            completion(resultData: (nil))
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
}