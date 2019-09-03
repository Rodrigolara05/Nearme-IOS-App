//
//  LoginViewController.swift
//  Nearme
//
//  Created by Alumnos on 6/6/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import os

class LoginViewController: UIViewController {
    
    var user: User = User.init()
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameOrpasswordErrorText: UILabel!
    
    var empty: String = ""
    
    var usernameOrpasswordErrorMessage: String = "invalid username or password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func handleResponse(response: User?) {
        guard let user = response
            else {
                self.user = User.init()
                return
        }
        self.user = user
        if(user.id != 0){
            usernameOrpasswordErrorText.text = empty
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else{
                return
            }
            mainViewController.user = self.user
            present(mainViewController, animated: true, completion: nil)
        }else{
            usernameOrpasswordErrorText.text = usernameOrpasswordErrorMessage
        }
    }
    
    func handleError(error: Error) {
        let message = "Error while requesting Users:\(error.localizedDescription)"
        os_log("%@", message)
        usernameOrpasswordErrorText.text = usernameOrpasswordErrorMessage
    }
    
    
    @IBAction func signInAction(_ sender: UIButton) {
        if(validatedInputs(input: passwordTextField.text) && validatedInputs(input: emailTextField.text)){
            
            NearmeApi.loginUser(
                username: emailTextField.text ?? "",
                password: passwordTextField.text ?? "",
                responseHandler: handleResponse, errorHandler: handleError,
                Key: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzbWFydHNvbHV0aW9udXBjIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE1NTkyODU1MTYsImV4cCI6MTU2MTg3NzUxNn0.xJRaMeNjuDZD6LO5v78_qG_ujTkElge14MuczsSC7cI")
        }
        else{
            usernameOrpasswordErrorText.text = usernameOrpasswordErrorMessage
        }
    }
    
    func validatedInputs(input: String?)->Bool{
        if(input == nil || input == ""){
            return false
        }else{
            return true
        }
    }
}

