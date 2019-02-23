//
//  Login ViewController.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 2/20/19.
//  Copyright © 2019 Peter Jaworski. All rights reserved.
//

import UIKit

class Login_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var userPasswordLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userPasswordLabel.delegate = self
        self.userNameLabel.delegate = self
        
        self.loginButton.layer.cornerRadius = 10.0
        self.loginButton.layer.borderWidth = 1.0
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loginView"{
            let viewController = segue.destination as! ViewController
        viewController.title = "Home"
    }
}
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if (userNameLabel.text?.contains("dirty"))! && (userPasswordLabel.text?.contains("DirtyDarts2019"))!{
             NSLog("Login Successful")
    
            performSegue(withIdentifier: "loginView", sender: nil)
            
        }
        else {NSLog("Login Failed")}
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
