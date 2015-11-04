//
//  ProfileViewController.swift
//  Kindling
//
//  Created by Mike Henry on 11/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var userImageView    :UIImageView!
    @IBOutlet weak var usernameLabel    :UILabel!
    @IBOutlet weak var firstNameLabel   :UILabel!
    @IBOutlet weak var lastNameLabel    :UILabel!
    @IBOutlet weak var emailLabel       :UILabel!
    @IBOutlet weak var genderLabel      :UILabel!
    @IBOutlet weak var orientationLabel :UILabel!
    @IBOutlet weak var ageLabel         :UILabel!
    
    
    //MARK: - Interactivity Methods
    
    func displayCurrentUserProfile() {
        let kindler = PFUser.currentUser()
        usernameLabel.text = kindler?.username
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentUserProfile()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
