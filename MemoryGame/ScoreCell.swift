//
//  ScoreCell.swift
//  MemoryGame
//
//  Created by Afnan Theb on 22/04/1443 AH.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var top: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
