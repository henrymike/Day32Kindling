//
//  DataManager.swift
//  Kindling
//
//  Created by Mike Henry on 11/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class DataManager: NSObject {
    
    //MARK: - Properties
    static let sharedInstance = DataManager()
    var dataArray = [PFUser]()
    
    
    //MARK: - Fetch Methods
    
    func fetchDataFromParse() {
        let fetch = PFUser.query()
//        let fetch = PFQuery(className: "User")
        fetch!.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Got Data")
                self.dataArray = objects as! [PFUser]
                print(self.dataArray)
                dispatch_async(dispatch_get_main_queue()) { // set listener
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
                }
            } else {
                print("No Data")
            }
        }
        
    }
    
    
}
