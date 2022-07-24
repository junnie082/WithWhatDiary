//
//  AddLogViewController.swift
//  JunDiary
//
//  Created by Hyojeong_Jun on 2022/07/20.
//

// MARK: - 사진을 라이브러리에서 가져오기 뿐만 아니라 앱에서 직접 촬영을 하는 기능을 넣는 것은 어때?
import UIKit
import MobileCoreServices
import CoreData
import Foundation

class AddLogViewController: UIViewController, UIPickerViewDelegate,
                            UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    // Emotion Picker
    let PICKER_VIEW_COLUMN = 1
    var emotions = ["happy", "sad", "excited", "depressed", "angry"]
    
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!

    @IBOutlet weak var withTextField: UITextField!
    @IBOutlet weak var whatTextField: UITextField!
    
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var pickerEmotions: UIPickerView!
    
    // Image Button
    @IBOutlet var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
       
        managedContext = appDelegate?.persistentContainer.viewContext

        let request: NSFetchRequest<Log> = Log.fetchRequest()

        if let log =
            try? appDelegate?.persistentContainer.viewContext.fetch(request),
           let with = log.first?.with,
           let what = log.first?.what,
           let date = log.first?.date {
            print("with: \(with), what: \(what), date: \(date)")
        } else {
            print("failed")
        }
        
        
        
        
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        
    }
    
    
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emotions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emotions[row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: 사진 및 비디오 불러오기 버튼
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
    
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.movie"]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinsihPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: "public.image" as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
        } else if mediaType.isEqual(to: "public.movie" as String) {
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: 경고
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: Add 버튼
    @IBAction func btnAddItem(_ sender: UIButton) {
        insertData()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Insert data
    func insertData() {

        let fetch: NSFetchRequest<Log> = Log.fetchRequest()
        fetch.predicate = NSPredicate(format: "searchKey != nil")

        let withCount = (try? managedContext.count(for: fetch)) ?? 0

        if withCount > 0 {
            // JunDiary.plist data already in Core Date
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Log", in: managedContext)!
        let log = Log(entity: entity, insertInto: managedContext)

        log.date =  pickerDate.date
        let image = UIImage(named: "PhotoJun.jpeg")
        log.image =  image?.jpegData(compressionQuality: 1.0)
        log.logID =  "Jun"
        log.photoID = "Jun's Happy Face"
        log.title =  "Jun's Happy Day"
        log.userID =  "21101223"
        log.with =  withTextField.text
        log.what =  whatTextField.text
        log.searchKey =  "Junnie"
        
        
        try? managedContext.save()
    }

}
