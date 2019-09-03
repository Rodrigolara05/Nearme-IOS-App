//
//  CreateAccountViewController.swift
//  Nearme
//
//  Created by alvaro on 6/28/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import os


class CreateAccountViewController: UIViewController {
    var gender = "Male"
    var emptyString = ""
    var message = "Invalid inputs"
    var user: User = User.init()
    var types = [Type_User].init()
    
    @IBOutlet weak var fullnameInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    
    @IBOutlet weak var errorMessage: UILabel!
    
    
    @IBOutlet weak var maleB: UIButton!
    
    @IBOutlet weak var femalB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maleB.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchMaleButton(_ sender: Any) {
        gender = "Male"
        maleB.isSelected = true
        femalB.isSelected = false
    }
    
    
    @IBAction func touchFemaleButton(_ sender: Any) {
        gender = "Female"
        maleB.isSelected = false
        femalB.isSelected = true
    }
    
    func handleResponseTypeUser(response: [Type_User]?) {
        print("llego al response")
        guard let typeUsers = response
            else {
                self.types = [Type_User].init()
                return
        }
        self.types = typeUsers
        if(types.count>0){
            errorMessage.text = emptyString
            for item in types {
                if(item.name == "Traveler"){
                    self.user.type_user_id = item
                    break
                }
            }
            if(self.user.type_user_id!.id > 0){
                print("va a hacer post al user")
                NearmeApi.postUser(
                    obj: self.user,
                    responseHandler: handleResponseUser,
                    errorHandler: handleErrorUser,
                    Key: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzbWFydHNvbHV0aW9udXBjIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE1NTkyODU1MTYsImV4cCI6MTU2MTg3NzUxNn0.xJRaMeNjuDZD6LO5v78_qG_ujTkElge14MuczsSC7cI")
            }
        }else{
           errorMessage.text = "fail"
        }
    }
    
    func handleErrorTypeUser(error: Error) {
        let message = "Error while requesting Type Users:\(error.localizedDescription)"
        os_log("%@", message)
        errorMessage.text = "fail"
    }
    
    func handleResponseUser(response: User?) {
        print("llego al response USER")
        var USER = User.init()
        do{
            USER = response!
            if(USER.id! > 0){
                errorMessage.text = emptyString
                print("llego el usuario")
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                guard let loguinViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else{
                    return
                }
                present(loguinViewController, animated: true, completion: nil)
                
            }else{
                errorMessage.text = "fail"
            }
        }
        catch{
            errorMessage.text = "fail"
        }
    }
    
    func handleErrorUser(error: Error) {
        let message = "Error while requesting Users:\(error.localizedDescription)"
        os_log("%@", message)
        errorMessage.text = "fail"
    }
    @IBAction func touchSaveButton(_ sender: Any) {
        if(validatedInputs(input: fullnameInput.text) &&
            validatedInputs(input: emailInput.text) &&
            validatedInputs(input: usernameInput.text) &&
            validatedInputs(input: passwordInput.text)){
            
            if(!validateLenght(input: fullnameInput.text!, len: 4)){
                errorMessage.text = "fullname min 4 characters"
            }else if(!isValidEmail(input: emailInput.text!)){
                errorMessage.text = "emai->example@domain.com"
            }else if(!validateLenght(input: usernameInput.text!, len: 4)){
                errorMessage.text = "username min 4 characters"
            }else if(!validateLenght(input: passwordInput.text!, len: 7)){
                errorMessage.text = "password min 7 characters"
            }else{
                errorMessage.text = emptyString
                user.email = emailInput.text!
                user.gender = self.gender
                user.fullname = fullnameInput.text!
                user.image = "empty"
                user.password = passwordInput.text!
                user.username = usernameInput.text!
                
                NearmeApi.getTypeUsers(
                    responseHandler: handleResponseTypeUser,
                    errorHandler: handleErrorTypeUser,
                    Key: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzbWFydHNvbHV0aW9udXBjIiwicm9sZXMiOlsiVVNFUiJdLCJpYXQiOjE1NTkyODU1MTYsImV4cCI6MTU2MTg3NzUxNn0.xJRaMeNjuDZD6LO5v78_qG_ujTkElge14MuczsSC7cI")
            }
        }else{
            errorMessage.text = message
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
