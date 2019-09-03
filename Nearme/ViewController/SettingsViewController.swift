//
//  SettingsViewController.swift
//  Nearme
//
//  Created by Alumnos on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class SettingsViewController: UIViewController {

    @IBOutlet weak var restaurantUIButton: UIButton!
    
    
    
    @IBOutlet weak var barUIButton: UIButton!
    
    @IBOutlet weak var NightclubUIButton: UIButton!
    
    @IBOutlet weak var hotelUIButton: UIButton!
    
    @IBOutlet weak var hotelUIButton2: UIButton!
    
    @IBOutlet weak var restaurantUILabel: UILabel!
    
    @IBOutlet weak var hotelUILabel: UIButton!
    
    @IBOutlet weak var hotelUILabel2: UILabel!
    
    @IBOutlet weak var barUILabel: UILabel!
        
    @IBOutlet weak var nightUILabel: UILabel!
    
    var categories = ["Restaurant","Hotel","Bar","Nightclub"]
    
    var persistance = [NSManagedObject]()
    
    var guardados:[String] = []
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entityName = "Preferences"
    
    func add(from preference: String) {
        if let entity = NSEntityDescription.entity(
            forEntityName: entityName, in: context) {
            let newObject = NSManagedObject(entity: entity, insertInto: context)
            newObject.setValue( preference, forKey: "name")
            save()
        }
    }
    
    func all() -> [NSManagedObject]? {
        return find(withPredicate: nil)
    }
    
    func save() {
        delegate.saveContext()
        print("hola")
    }
    
    func find(withPredicate predicate: NSPredicate?) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let predicate = predicate {
            request.predicate = predicate
        }
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        } catch {
            print("Error while querying: \(error.localizedDescription)")
        }
        return nil
    }
    
    func find(byNameAsBool name: String) -> Bool {
        let predicate = NSPredicate(format: "name = %@", name)
        if find(withPredicate: predicate) != nil {
            return false
        }
        return true
    }
    
    func find(byName name: String) -> NSManagedObject? {
        let predicate = NSPredicate(format: "name = %@", name)
        if let result = find(withPredicate: predicate) {
            return result.first
        }
        return nil
    }
    
    func delete(for source:String) {
        if let favorite = find(byName: source) {
            do {
                try favorite.validateForDelete()
                context.delete(favorite)
                save()
            } catch {
                print("Error while deleting: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func buttons(cont: Int) {
        if (cont==0){
            print("1 resta")
            restaurantUIButton.isSelected = true
            print("2 resta")
        }
        if (cont==1){
            print("hotel 1")
            hotelUIButton2.isSelected = true
            print("hotel 2")
        }
        if (cont==2){
            print("bar 1")
            barUIButton.isSelected = true
            print("bar 2")
        }
        if (cont==3){
            print("Night 1")
            NightclubUIButton.isSelected = true
            print("Night 2")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         var cont = 0
        for i in categories {
            
            if (find(byName: i) != nil){
                buttons(cont: cont)
                print("Tamaño"+"")
            }
            cont+=1
        }
    }
    
    @IBAction func checkBoxTapped1(_ sender: UIButton) {
        
        if sender.isSelected {
            delete(for: categories[0])
        } else {
            add(from: categories[0])
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
      
    }
    
    @IBAction func checkBoxTapped2(_ sender: UIButton) {
        if sender.isSelected {
            delete(for: categories[1])
        } else {
            add(from: categories[1])
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    @IBAction func checkBoxTapped3(_ sender: UIButton) {
        if sender.isSelected {
            delete(for: categories[2])
        } else {
            add(from: categories[2])
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    @IBAction func checkBoxTapped4(_ sender: UIButton) {
        if sender.isSelected {
            delete(for: categories[3])
        } else {
            add(from: categories[3])
            
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
       
    }
    
}
