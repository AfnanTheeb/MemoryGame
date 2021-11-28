 //
//  ViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 16/04/1443 AH.
//

import UIKit
import CoreData
class MemoryGameVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
    var player : Player?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var imgeCardArr = [
        UIImage(named: "image1"),
        UIImage(named: "image1") ,
        UIImage(named: "image2") ,
        UIImage(named: "image2") ,
        UIImage(named: "image3") ,
        UIImage(named: "image3") ,
        UIImage(named: "image8") ,
        UIImage(named: "image8") ,
        UIImage(named: "image4") ,
        UIImage(named: "image4") ,
        UIImage(named: "image5") ,
        UIImage(named: "image5") ,
        UIImage(named: "image6") ,
        UIImage(named: "image6") ,
        UIImage(named: "image7"),
        UIImage(named: "image7")]
    
    
    //     timer ----------------
    
    var timer : Timer? = Timer()
    var counter : Double = 0
    var currentSelectedIndex = 0
    var lastSelectedIndex : Int?
    var countMatch : Int = 0
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var pairsLabel: UILabel!
    
    func setUp(){
        
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.1,
                                              target: self,
                                              selector: #selector(timerMethod),
                                              userInfo: nil,
                                              repeats: true )
            
            
        }
        
    }
    
    
        @objc func timerMethod (){
            
            counter += 1
            let time = seconds(second: Int(counter))
            let timeString = maketime(hours: time.0, minutes: time.1, second: time.2)
            timerLable.text = timeString
        }

// stop timer and save
    
    override func viewWillDisappear(_ animated: Bool) {
        print (".......")
    
    }
    
    
    func seconds (second : Int)-> (Int, Int , Int){
        
        return ((second/3600), ((second % 3600) / 60 ) , ((second % 3600) % 60))
    }
    func maketime(hours : Int, minutes : Int , second : Int)-> String{
        
        
        var timeString = ""
        timeString += String(format: "%02d ", hours)
        
        
         timeString += " : "
        timeString += String(format: "%02d ", minutes)
         timeString  += " : "
        timeString += String(format: "%02d ", second)
        
        return timeString
    }
  
    
    //  -------------   func delegate
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgeCardArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardID", for: indexPath) as! ImagesCards
        cell.images.image = imgeCardArr[indexPath.row]
        
        
        return cell
    }
    
    

//     func delete match image
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedIndex = indexPath.row
        // to save last click cell
        // save object to allow change
        var lastCell : ImagesCards?
        let currCellObject = collectionView.cellForItem(at: indexPath) as! ImagesCards
        // to unwrap optional value
        if let lastSelectedIndex = lastSelectedIndex {
            lastCell = collectionView.cellForItem(at: IndexPath(item: lastSelectedIndex, section: 0)) as? ImagesCards
        }
        
        currCellObject.frontImage.isHidden = true


        if lastSelectedIndex != nil  {


            if (imgeCardArr[lastSelectedIndex!] == imgeCardArr[currentSelectedIndex] && lastSelectedIndex != indexPath.row) {
                countMatch += 1
                pairsLabel.text = "Pairs (8/\(countMatch))"
                print("Matched")
                // show image cell to player
                currCellObject.frontImage.isHidden = true
                // to stop clcik
                currCellObject.isUserInteractionEnabled = false
                lastCell?.frontImage.isHidden = true
                lastCell?.isUserInteractionEnabled = false
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                    currCellObject.images.alpha = 0.3
                    lastCell?.images.alpha = 0.3
                    
                }
                
                
                //cellObject.updateCell(false)
            } else {
                print("Not matched")
                Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
                    lastCell?.frontImage.isHidden = false
                    currCellObject.frontImage.isHidden = false
                    
                }
            }
            lastSelectedIndex = nil
        } else {
            print("Keep going")
            currCellObject.frontImage.isHidden = true
            lastSelectedIndex = indexPath.row
        }
        
        if countMatch == 8 {
            collectionView.isUserInteractionEnabled = false
            
            print("Stop Timer")
            timer?.invalidate()
            print("Score: \(counter)")
            showAlert(result: timerLable.text!)
            
            
        }
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print("name player \(player?.username)")
        collectionView.register(UINib(nibName: "ImagesCards", bundle: nil), forCellWithReuseIdentifier: "cardID")
        setUp()
        //imgeCardArr.shuffle()
        }
    
    
    
    
        
    //         alert
    func showAlert (result: String){
        print("User is: \(player?.username)")
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Player")
        // Update Player
        if let username = player?.username {
            do {
                fetchRequest.predicate = NSPredicate(format: "username = %@", username)

                let fetchPlayer = try context.fetch(fetchRequest)
                print("User: \(fetchPlayer)")
                if fetchPlayer.indices.contains(0) {
                    print("User found")
                    let playerProfile = fetchPlayer[0] as! Player
                    let userScore = Score(context: context)
                    userScore.result = result
                    playerProfile.score?.insert(userScore)
                    print(playerProfile)
    
                    try context.save()
                }
        
            } catch {
                print("Cannot save score")
            }
        }
        timerLable.text = ".. GAME OVER .."
        timerLable.textColor = .red
        timerLable.font = UIFont(name: ".SFUI-Semibold", size: 21)
        let alert = UIAlertController(title:" Great ", message: "Time  (\(result))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Replay", style: .cancel, handler: {action in
            
            self.navigationController?.popViewController(animated: true)

        }))
        
        alert.addAction(UIAlertAction(title: "Show profile", style: .default , handler: {action in


            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "profileID") as! ProfileViewController
            profileVC.player = self.player
            self.present(profileVC, animated : true)
        }))
        present(alert, animated : true)
    }

    
}
