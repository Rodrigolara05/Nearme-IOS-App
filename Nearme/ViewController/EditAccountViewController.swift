//
//  EditAccountViewController.swift
//  Nearme
//
//  Created by Alumnos on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import os

class EditAccountViewController: UIViewController {

    var gender = ""
    var emptyString = ""
    var message = "invalid inputs"
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    var user = User()
    
    
    @IBOutlet weak var buttonMale: UIButton!
    
    
    @IBOutlet weak var buttonFemale: UIButton!
    
    
    @IBOutlet weak var errorEdit: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gender = user.gender!
        fullNameTextField.text = user.fullname
        emailTextField.text = user.email
        passwordTextField.text = user.password
        usernameTextField.text = user.username
        if(user.gender == "Male"){
            buttonMale.isSelected = true
            buttonFemale.isSelected = false
        }else if(user.gender == "Female"){
            buttonMale.isSelected = false
            buttonFemale.isSelected = true
        }
        // Do any additional setup after loading the view.
    }
    
    func handleResponseUser(response: User?) {
        print("llego al response USER")
        var USER = User.init()
        do{
            USER = response!
            if(USER.id! > 0){
                errorEdit.text = emptyString
                
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                guard let myAccountViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MyAccountViewController") as? MyAccountViewController else{
                    return
                }
                print("Lo que estoy pasandole")
                print(USER.fullname)
                myAccountViewController.user = USER
            }else{
                errorEdit.text = "fail"
            }
        }
        catch{
            errorEdit.text = "fail"
        }
    }
    
    func handleErrorUser(error: Error) {
        let message = "Error while requesting Users:\(error.localizedDescription)"
        os_log("%@", message)
        errorEdit.text = "fail"
    }
    
    @IBAction func touchSveButton(_ sender: Any) {
        if(validatedInputs(input: fullNameTextField.text) &&
            validatedInputs(input: emailTextField.text) &&
            validatedInputs(input: usernameTextField.text) &&
            validatedInputs(input: passwordTextField.text)){
            
            if(!validateLenght(input: fullNameTextField.text!, len: 4)){
                errorEdit.text = "fullname min 4 characters"
            }else if(!isValidEmail(input: emailTextField.text!)){
                errorEdit.text = "emai->example@domain.com"
            }else if(!validateLenght(input: usernameTextField.text!, len: 4)){
                errorEdit.text = "username min 4 characters"
            }else if(!validateLenght(input: passwordTextField.text!, len: 7)){
                errorEdit.text = "password min 7 characters"
            }else{
                errorEdit.text = emptyString
                user.email = emailTextField.text!
                user.gender = self.gender
                user.fullname = fullNameTextField.text!
                user.password = passwordTextField.text!
                user.username = usernameTextField.text!
                
                print(user.id)
                print(user.gender)
                NearmeApi.putUser(
                    obj: self.user,
                    responseHandler: handleResponseUser,
                    errorHandler: handleErrorUser,
                    Key: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzbWFydHNvbHV0aW9udXBjIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE1NTkyODU1MTYsImV4cCI6MTU2MTg3NzUxNn0.xJRaMeNjuDZD6LO5v78_qG_ujTkElge14MuczsSC7cI")
            }
        }else{
            errorEdit.text = message
        }
    }
    
    
    
    @IBAction func touchMaleButton(_ sender: Any) {
        self.gender = "Male"
        buttonMale.isSelected = true
        buttonFemale.isSelected = false
    }
    
    
    @IBAction func touchFemalButton(_ sender: Any) {
        self.gender = "Female"
        buttonMale.isSelected = false
        buttonFemale.isSelected = true
    }
    
    func validateLenght(input: String, len:Int) -> Bool {
        if(input.count>=len){
            return true
        }else{
            return false
        }
    }
    
    func isValidEmail(input:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    }
    
    func validatedInputs(input: String?)->Bool{
        if(input == nil || input == ""){
            return false
        }else{
            return true
        }
    }
}
