 //
//  ViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 16/04/1443 AH.
//

import UIKit

class MemoryGameVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
        
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
    var gameComplete : Bool = false
    @IBOutlet weak var timerLable: UILabel!
    
    
    func setUp(){
        
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 1,
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
        
        return ((second / 3600 ), ((second % 3600) / 60 ) , ((second % 3600) % 60))
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
        var lastCell : ImagesCards?
        let cellObject = collectionView.cellForItem(at: indexPath) as! ImagesCards
        if let lastSelectedIndex = lastSelectedIndex {
            lastCell = collectionView.cellForItem(at: IndexPath(item: lastSelectedIndex, section: 0)) as! ImagesCards
        }
        


        if lastSelectedIndex != nil  {
            cellObject.frontImage.isHidden = true
            if (imgeCardArr[lastSelectedIndex!] == imgeCardArr[currentSelectedIndex] && lastSelectedIndex != indexPath.row) {
                countMatch += 1
                print("Matched")
                cellObject.frontImage.isHidden = true
                cellObject.isUserInteractionEnabled = false
                lastCell?.frontImage.isHidden = true
                lastCell?.isUserInteractionEnabled = false
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                    cellObject.images.alpha = 0.3
                    lastCell?.images.alpha = 0.3
                    
                }
                
                
                //cellObject.updateCell(false)
            } else {
                print("Not matched")
                Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
                    lastCell?.frontImage.isHidden = false
                    cellObject.frontImage.isHidden = false
                    
                }
            }
            lastSelectedIndex = nil
        } else {
            print("Keep going")
            cellObject.frontImage.isHidden = true
            lastSelectedIndex = indexPath.row
        }
        
        if countMatch == 8 {
            collectionView.isUserInteractionEnabled = false
            
            print("Stop Timer")
            timer?.invalidate()
            print("Score: \(counter)")
            showAlert(result: String(counter))
            
            
        }
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ImagesCards", bundle: nil), forCellWithReuseIdentifier: "cardID")
        
        setUp()
//        imgeCardArr.shuffle()
        }
    
    
    
    
        
    //         alert
    func showAlert (result: String){
        timerLable.text = ".. GAME OVER .."
        timerLable.textColor = .red
        timerLable.font = UIFont(name: ".SFUI-Semibold", size: 25)
                let alert = UIAlertController(title: nil, message: result, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {action in

                }))

                present(alert, animated : true)
    }
    
    
}
