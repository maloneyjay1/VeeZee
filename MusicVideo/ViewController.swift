//
//  ViewController.swift
//  MusicVideo
//
//  Created by Jay Maloney on 2/18/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NetworkController.baseMusicURLForLimit(10)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            
            let alert = UIAlertController(title: "Data Task Successful", message: nil, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: (nil))
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: (nil))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

