//
//  ProfileViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 19/04/1443 AH.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate , UITableViewDataSource  {
    
    // TODO: Change to actual context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var round : [String]?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
