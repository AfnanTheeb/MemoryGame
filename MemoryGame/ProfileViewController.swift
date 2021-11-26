//
//  ProfileViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 19/04/1443 AH.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    // TODO: Change to actual context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var round : [String]?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    
    @IBAction func onClickSelectIamge(_ sender: Any) {
        actionSeet()
    }
//    func add image in profile
    
    func actionSeet(){
        
   
                        let alert = UIAlertController(title:" choose camera", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "open camera", style: .default, handler: {action in
                            self.openCamera()
                          
                        }))
        alert.addAction(UIAlertAction(title: "gallery", style: .default, handler: {action in
            self.openGallery()
        }))


        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: {action in

        }))

        self.present(alert, animated : true , completion: nil)
        
        
        
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let image = UIImagePickerController()
            image.allowsEditing = true
            image.sourceType = .camera
            self.present(image ,animated: true , completion: nil)
        }
        
    }

    
    func openGallery (){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController.self()
            picker.allowsEditing = true
                picker.delegate = self
            
            self.present(picker, animated: true , completion: nil )
    
            }
            
        }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imageProfile.image = img
        }
        dismiss(animated: true  )
    }
    
    //----------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return round?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
      //  cell.textLabel?.text = result[indexPath.row].name
     return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
     
        // Do any additional setup after loading the view.
        
        var round1 = Round(context: context)
        round1.result = String(343)
        
        var player1 = Player(context: context)
        
        // Assign Round as relationship to Player
        player1.addToToRound(round1)
//        player1.addToToRound(round2)
        
        // Access attribute from Round Entity like this
        player1.toRound?.value(forKey: "result")
        
        
        

   }
    //----------- Use tap gesture recognizer to delete image
    @IBAction func tapAction(_ sender: Any) {
        print ("...")
        
        let alertItem = UIAlertController(title: "Are you sure to Delete?!", message: nil, preferredStyle: .alert)
        alertItem.addAction(UIAlertAction(title: "yes", style: .default, handler: { [self]action in
             self.imageProfile.removeFromSuperview()

          }))
          alertItem.addAction(UIAlertAction(title: "no", style: .default, handler: {action in
              self.openCamera()
          }))
          present(alertItem, animated: true, completion: nil)
    }
    }

  
    



