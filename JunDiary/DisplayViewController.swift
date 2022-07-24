//
//  DisplayViewController.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/20.
//

import UIKit
import CoreData
import Foundation

class DisplayViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var whatLabel: UILabel!
    @IBOutlet var withLabel: UILabel!
    @IBOutlet var emotionLabel: UILabel!
    @IBOutlet var imageDisplay: UIImageView!
    
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        // fetch!
        let request: NSFetchRequest<Log> = Log.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K = %@",
            argumentArray: [#keyPath(Log.searchKey)])
        
        do {
            // 3
            let results = try managedContext.fetch(request)
            
            // 4
            if let log = results.first {
                populate(log: log)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        
        func populate(log: Log) {
            
            guard let logDate = log.date as Date?,
                 // let logImage = log.image as binaryData?,
                  let logTitle = log.title as String?,
                  let logWith = log.with as String?,
                  let logWhat = log.what as String? else {
                return
            }
            
            let dateFormatter = DateFormatter()
            
            dateLabel.text = dateFormatter.string(from: logDate)
            titleLabel.text = logTitle
            whatLabel.text = logWhat
            withLabel.text = logWith
                  
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
