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
    
    let kindler = PFUser.currentUser()
    
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
        userImageView.image = UIImage(named: "person")
        usernameTextField.text = kindler!.username
        if kindler!["firstName"] != nil {
            firstNameTextField.text! = (kindler!["firstName"] as! String)
        } else {
            print("Error")
        }
        if kindler!["lastName"] != nil {
            lastNameTextField.text = (kindler!["lastName"] as! String)
        } else {
            print("Error")
        }
        emailTextField.text = kindler!.email
        if kindler!["gender"] != nil {
            genderTextField.text = (kindler!["gender"] as! String)
        } else {
            print("Error")
        }
        if kindler!["orientation"] != nil {
            orientationTextField.text = (kindler!["orientation"] as! String)
        } else {
            print("Error")
        }
        if kindler!["age"] != nil {
            ageTextField.text = (kindler!["age"] as! String)
        } else {
            print("Error")
        }
    }
    
    @IBAction func saveButtonPressed() {
        print("Save Pressed")
        kindler!.username = usernameTextField.text
        kindler!["firstName"] = firstNameTextField.text
        kindler!["lastName"] = lastNameTextField.text
        kindler!.email = emailTextField.text
        kindler!["gender"] = genderTextField.text
        kindler!["orientation"] = orientationTextField.text
        kindler!["age"] = ageTextField.text
        saveAndPop()
    }
    
    func saveAndPop() {
        do {
            try kindler!.save()
        } catch {
            print("Save Error")
        }
        navigationController?.popViewControllerAnimated(true)
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
