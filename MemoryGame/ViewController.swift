//
//  ViewController.swift
//  MemoryGame
//
//  Created by Afnan Theb on 16/04/1443 AH.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {
    
//    var cardImges = [Cards]()
    let imgeCardArr = [UIImage(named: "moon1")]
    
    //     timer ----------------
    @IBOutlet weak var timerLable: UILabel!
//    var timer : Timer?
//    var milliSeconds : Float = 30 * 1000
//
//

    

    @IBOutlet weak var collectionView: UICollectionView!
//  -------------   func delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgeCardArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardID", for: indexPath) as! ImagesCards
           cell.images.image = imgeCardArr[0]
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ImagesCards", bundle: nil), forCellWithReuseIdentifier: "cardID")
        //        create timer
//        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true )
//
//        RunLoop.main.add(timer! , forMode: .common)
//
       
        // Do any additional setup after loading the view.
        
    }
    
    
    
//    timer func -----------------
//    @objc func timerElapsed(){
//
//        milliSeconds -= 1
//        conver to seconds
//        let seconds = String(format: "%.2f", milliSeconds/1000)
//        set lable
//        timerLable.text = "time :"
//        when timer stop
//        if milliSeconds <= 0 {
//            timer?.invalidate()
//            timerLable.textColor = UIColor.red
//
//
//
//        }
//
        
        
        
        
    }
    
    
    
//    func login(enteredUsernsme: String, enteredpassword: String){
//        if username == enteredUsernsme && password == enteredpassword {
//
//        }
//    }

//}

