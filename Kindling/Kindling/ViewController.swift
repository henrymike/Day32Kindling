//
//  ViewController.swift
//  Kindling
//
//  Created by Mike Henry on 11/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet var loginButton   :UIBarButtonItem!
    
    
    
    //MARK: - User Default Methods
    
    func setUsernameDefault(username: String) { // this allows 'Remember Me' for when you come back
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(username, forKey: "DefaultUsername")
        userDefaults.synchronize()
    }
    
    func getUsernameDefault() -> String {
        if let defaultUsername = NSUserDefaults.standardUserDefaults().stringForKey("DefaultUsername") {
            return defaultUsername
        } else {
            return ""
        }
    }
    
    
    //MARK: - Login Methods
    
    @IBAction func loginButtonPressed(sender: UIBarButtonItem) {
        if let _ = PFUser.currentUser() {
            PFUser.logOut()
            loginButton.title = "Log In"
        } else {
            let loginController = PFLogInViewController()
            loginController.delegate = self
            let signupController = PFSignUpViewController()
            signupController.delegate = self
            loginController.signUpController = signupController
            loginController.logInView?.usernameField?.text = getUsernameDefault() // adds default username
            presentViewController(loginController, animated: true, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        setUsernameDefault(logInController.logInView!.usernameField!.text!) // sets default username
        loginButton.title = "Log Out"
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        loginButton.title = "Log Out"
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        loginButton.title = "Log In"
        dataManager.fetchDataFromParse()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

