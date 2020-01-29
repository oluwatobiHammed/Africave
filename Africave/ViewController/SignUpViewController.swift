//
//  SignUpViewController.swift
//  Africave
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElement()
    }
    
    func setUpElement() {
        
        // Hide the Error Label
        errorLabel.alpha = 0
        
        // Style the element
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    /* Check the fields and validate that the data is correct.
       If everything is correct, this method returns nil. Otherwise,
       it returns the error messsage */
    func valideteFields() -> String?{
        
        // Check that all fields are filled in
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        // Check if the password is correct
        
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false {
            
            // password isn't secure enough
            return "please make sure your password is at least 8 charaters, contains a special character and a number"
        }
        
        return nil
        
    }

    @IBAction func signUpTapped(_ sender: UIButton) {
        // Validate the Fields
        let error = valideteFields()
        
        if error != nil {
            // There's something wrong with he fields, show error message
            showErrorMessage(error!)
        } else {
            
            let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the User
            Client.signup(username: userName, password: password, email: email) { (success, Error) in
                
                //check for errors
                if Error != nil {
                    
                    // There was an error creating the user
                    self.showErrorMessage("Error creating user")
                }else {
                    
                    self.transitionToHome()
                }
            }
                  //There was error creating user
            
                  
            //Transition to the home Screen
            
           
        }
        
      
    }
    
    func showErrorMessage(_ message: String)  {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func  transitionToHome()  {
        let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
