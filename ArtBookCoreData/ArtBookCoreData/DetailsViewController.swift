//
//  DetailsViewController.swift
//  ArtBookCoreData
//
//  Created by Macbook Air on 16.02.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    //var chosenPainting = ""
    //var chosenPaintingId:UUID?
    
    var painter:Paintings?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    let context = appDelegate.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let painter = painter {
            saveButtonOutlet.isHidden = true
            nameTextField.text = painter.name
            artistTextField.text = painter.artist
            yearTextField.text = String(painter.year)
            imageView.image = UIImage(data: painter.image!)
        }
        
        
        
        /*if chosenPainting != "" {
            
            //saveButtonOutlet.isEnabled = false
            saveButtonOutlet.isHidden = true
            
            //let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String{
                            nameTextField.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistTextField.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int {
                            yearTextField.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            } catch  {
                print(error.localizedDescription)
            }
        }else{
            saveButtonOutlet.isHidden = false
            saveButtonOutlet.isEnabled = false
            nameTextField.text = ""
            artistTextField.text = ""
            yearTextField.text = ""
        }*/
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext // context called and using context*/
    
        /*let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPainting.setValue(nameTextField.text!, forKey: "name")
        newPainting.setValue(artistTextField.text!, forKey: "artist")
        if let year = Int(yearTextField.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let incomingData = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(incomingData, forKey: "image")
        
        do {
            try context.save()
            print("success")
        } catch  {
            print(error.localizedDescription)
        }*/
        //NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        
        if let name = nameTextField.text, let artist = artistTextField.text, let year = yearTextField.text, let image = imageView.image{
            let painter = Paintings(context: context)
            painter.name = name
            painter.artist = artist
            painter.year = year
            painter.image = UIImage(data: image!)
            appDelegate.saveContext()
            
        }
        
        
        
        
           /* @IBOutlet weak var imageView: UIImageView!
            @IBOutlet weak var nameTextField: UITextField!
            @IBOutlet weak var artistTextField: UITextField!
            @IBOutlet weak var yearTextField: UITextField!
            @IBOutlet weak var saveButtonOutlet: UIButton!*/
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    

}

extension DetailsViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButtonOutlet.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
