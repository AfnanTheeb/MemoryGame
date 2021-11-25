//
//  startGames.swift
//  MemoryGame
//
//  Created by نجود  on 17/04/1443 AH.
//

import UIKit

class StartGames: UIViewController {

    
    @IBAction func startBtn(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "gameID") as? MemoryGameVC {self.navigationController?.pushViewController(vc, animated: true)}
       
//        timmer 
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
