//
//  MyAccountViewController.swift
//  Nearme
//
//  Created by Alumnos on 6/6/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordLabell: UILabel!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myTabBar: MainViewController {
            return tabBarController as! MainViewController
        }
        user = myTabBar.user
        print("llego al tab bar controller item")
        print(user.fullname)
        fillFields()
        // Do any additional setup after loading the view.
    }
    
    
    func fillFields(){
        fullNameLabel.text = user.fullname
        emailLabel.text = user.email
        passwordLabel.text = user.password
        userNameLabel.text = user.username
        genderLabel.text = user.gender
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "pasarDatos"){
            let editAccount = segue.destination as! EditAccountViewController
            print(user.fullname)
            editAccount.user = self.user
        }
    }
    
}
