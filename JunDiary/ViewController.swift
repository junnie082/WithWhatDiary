//
//  ViewController.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/18.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        // 1
        //insertData()
        
        // 2 어떻게 Fetch??
    }

    @IBAction func loginBtn(_ sender: UIButton) {
    }
    
    
    // Insert data

    
}

