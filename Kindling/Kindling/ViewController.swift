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

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet weak var loginButton           :UIBarButtonItem!
    @IBOutlet weak var kindlerCollectionView :UICollectionView!
    
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! KindlingCollectionViewCell
        let kindler = dataManager.dataArray[indexPath.row]
        cell.userNameLabel.text = kindler.username!  //kindler["age"]
        print("Username:\(kindler.username!)")
        if kindler["age"] != nil {
            cell.userAgeLabel.text = (kindler["age"] as! String)
        } else {
            print("Error")
        }
        if kindler["gender"] != nil {
            cell.userGenderLabel.text = (kindler["gender"] as! String)
        } else {
            print("Error")
        }
        cell.userImageView.image = UIImage(named: "person")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(150, 200)
    }
    
    func newDataReceived() {
        print("New Data Received")
        kindlerCollectionView.reloadData()
    }
    
    
    
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil) // listens for fetch

    }
    
    override func viewWillAppear(animated: Bool) {
        dataManager.fetchDataFromParse()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil) // listens for fetch
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

