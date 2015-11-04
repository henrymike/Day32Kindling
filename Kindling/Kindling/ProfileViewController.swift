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
    
    @IBOutlet weak var userImageView        :UIImageView!
    @IBOutlet weak var usernameTextField    :UITextField!
    @IBOutlet weak var firstNameTextField   :UITextField!
    @IBOutlet weak var lastNameTextField    :UITextField!
    @IBOutlet weak var emailTextField       :UITextField!
    @IBOutlet weak var genderTextField      :UITextField!
    @IBOutlet weak var orientationTextField :UITextField!
    @IBOutlet weak var ageTextField         :UITextField!
    
    
    //MARK: - Interactivity Methods
    
    func displayCurrentUserProfile() {
        let kindler = PFUser.currentUser()
        usernameTextField.text = kindler!.username
        emailTextField.text = kindler!.email
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
