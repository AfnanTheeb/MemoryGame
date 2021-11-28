//
//  ProfileViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 19/04/1443 AH.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    var player : Player?
    // TODO: Change to actual context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var round : [Score]? = []
   
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreCell
        cell.score.text = round?[indexPath.row].result

        if indexPath.row == 0 {
            cell.top.isHidden = false
        } else {
            cell.top.isHidden = true
        }
     return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
//    
        nameLabel.text = player?.username
        emailLabel.text = player?.email
        fetchPlayer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "ScoreCell", bundle: nil), forCellReuseIdentifier: "scoreCell")
        fetchPlayer()
        // Do any additional setup after loading the view.

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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            do {
                try context.delete((round?[indexPath.row])!)
                try context.save()
            } catch {
                print("error delete")
            }
            round?.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
            fetchPlayer()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
//tableView.reloadData()
    }
    func fetchPlayer(){
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Player")
        do {
            if let player = player?.username {
                fetchRequest.predicate = NSPredicate(format: "username = %@", player)
                
            }
            
            let fetchPlayer = try context.fetch(fetchRequest) as! [Player]
            round = []
            fetchPlayer[0].score?.forEach({ score in
                round?.append(score)
            })
            
        } catch {
            print("Cannot save score")
        }
        
        round = round?.sorted(by: { lhs, rhs in
            return lhs.result! < rhs.result!
        })
        tableview.reloadData()
        
    }
}

  
    



