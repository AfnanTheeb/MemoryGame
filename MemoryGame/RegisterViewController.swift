//
//  RegisterViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 19/04/1443 AH.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func createPlayer(){
        
        // Fetch using predicate of given Username - name.text
        // If there is at least one record then User already exist
        
        
        
        let playerEntity = NSEntityDescription.entity(forEntityName: "Player", in: context)!
        
        let newUser = NSManagedObject(entity: playerEntity, insertInto: context) as! Player
        newUser.username = name.text
        newUser.email = email.text
        newUser.password = passWord.text
        newUser.score = Set()
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed save new player")
        }
    }
    @IBAction func register(_ sender: Any) {
        
        if (email.text == confirmEmail.text){
            createPlayer()
        } else {
            print("Email not matched")
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
