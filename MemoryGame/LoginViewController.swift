//
//  LoginViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 19/04/1443 AH.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bgImg: UIImageView!
    
    
    var player : Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.alpha = 0
        bgImg.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    
    
    
//  --------------   animtion in background image and label --------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, animations:{
            self.bgImg.alpha = 0.6
        } ){(true) in
            UIView.animate(withDuration: 1, animations : {
                self.label.alpha = 1
            } , completion : {(true ) in
                
            })
        }
        
        
        
    }
    
//    ----------------
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getUser(username: String?, password: String?){
        if let username = username, let password = password {
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Player")
            fetchRequest.predicate = NSPredicate(format: "username = %@", username)
            
            do {
                let fetchPlayer = try context.fetch(fetchRequest)
                if fetchPlayer.indices.contains(0) {
                    let myPlayer = fetchPlayer[0] as! Player
                        print(myPlayer.username ?? "Not Found")
                        print(myPlayer.password ?? "Not Found")
                        print(myPlayer.email ?? "Not Found")
                    player = myPlayer
                    
                    performSegue(withIdentifier: "tabbarVC", sender: nil)
                } else {
                    print("User not found")
                }
            } catch {
                print("Error fetch user")
            }

        } else {
            print("Complete username/password field")
        }
    }
    @IBAction func loginAction(_ sender: Any) {
        
        getUser(username: username.text, password: password.text)
        username.text = ""
        password.text = ""
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tabbarVC" {
            let tabbarVC = segue.destination as! UITabBarController
            print(tabbarVC.viewControllers)
            let startsGameVC = tabbarVC.viewControllers?[0] as! StartGames
            startsGameVC.player = player
            let profileVC = tabbarVC.viewControllers?[1] as! ProfileViewController
            profileVC.player = player
        }
    }
    

}
