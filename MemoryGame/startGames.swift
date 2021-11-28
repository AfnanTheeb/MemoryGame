//
//  startGames.swift
//  MemoryGame
//
//  Created by نجود  on 17/04/1443 AH.
//

import UIKit

class StartGames: UIViewController {

    var player : Player?
    @IBAction func startBtn(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("user login \(player?.username)")
        // Do any additional setup after loading the view.
    }
    
    func showProfile(){
        self.tabBarController?.selectedIndex = 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goGame" {
        let gameVC = segue.destination as! MemoryGameVC
        gameVC.player = player
        }
    }

}
