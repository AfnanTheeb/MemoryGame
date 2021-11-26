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
    
    var timer = Timer()
    var counter = 0
    var selectedCellIndex = 0
    
    @IBOutlet weak var timerLable: UILabel!
    
  
    
    //  -------------   func delegate
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgeCardArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardID", for: indexPath) as! ImagesCards
        cell.images.image = imgeCardArr[indexPath.row]
        
        if (lastSelectedIndex == indexPath.row || selectedCellIndex == indexPath.row) {
            cell.updateCell(false)
        } else {
            cell.updateCell(true)
        }
        
        return cell
    }
    //    ---------------
    
    
    
    var lastSelectedIndex : Int?
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
        
        let cellObject = collectionView.cellForItem(at: indexPath) as! ImagesCards
        print("selected image: \(cellObject.images.image)")
        print("prev image: \(imgeCardArr[indexPath.row])")
        if lastSelectedIndex != nil  {
            if (imgeCardArr[lastSelectedIndex!] == cellObject.images.image && lastSelectedIndex != indexPath.row) {
                print("Matched")
                lastSelectedIndex = nil
                //cellObject.updateCell(false)
            }
        } else {
            print("Keep going")
            lastSelectedIndex = indexPath.row
        }
        print("Last index: \(lastSelectedIndex), current Index: \(selectedCellIndex)")
        
        collectionView.reloadData()
        
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ImagesCards", bundle: nil), forCellWithReuseIdentifier: "cardID")
        
        setUp()
        }
    
    
    
    
        
    //         alert
//            func showAlert (){
//                let alert = UIAlertController(title: nil, message: "result ", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {action in
//
//                }))
//
//                present(alert, animated : true)
//
//
        
        
        
        
    
    func setUp(){
        
        
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(timerMethod),
                                              userInfo: nil,
                                              repeats: true )
            
            
        }
        
    }
    
    
        @objc func timerMethod (){
            timerLable.text = String(counter)
            counter += 1
           
        }
//
//    func stopTimer(){
//        timer.invalidate()
//    }
//
    
    override func viewWillDisappear(_ animated: Bool) {
        print (".......")
    }
    
    
}

 
        
   
    
    
    
//    func login(enteredUsernsme: String, enteredpassword: String){
//        if username == enteredUsernsme && password == enteredpassword {
//
//        }
//    }

//}

