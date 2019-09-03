//
//  MainViewController.swift
//  Nearme
//
//  Created by Alumnos on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("nombre")
        print(user.fullname!)
        // Do any additional setup after loading the view.
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
