//
//  ImagesCards.swift
//  MemoryGame
//
//  Created by Reem Saleh on 16/04/1443 AH.
//

import UIKit

class ImagesCards: UICollectionViewCell {

    @IBOutlet weak var images: UIImageView!
    
    
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var viewEmpty: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func updateCell(_ canShow: Bool) {
        if (canShow == true) {
            viewEmpty.backgroundColor = .none
        } else {
            viewEmpty.backgroundColor = .white
        }
    }

}
