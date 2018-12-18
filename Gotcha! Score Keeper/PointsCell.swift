//
//  PointsCell.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 12/6/18.
//  Copyright © 2018 Peter Jaworski. All rights reserved.
//

import UIKit
//Testing Protocols. Not needed in code.
/*protocol ScoreCellDelegate {
    func didTappedButton (index: Int)
}*/

class PointsCell: UITableViewCell {
    
   // var delegate : ScoreCellDelegate? - Needed for protocols. Need to setup a delegate variable
    var winScore = 0
    @IBOutlet weak var scoreUILabel: UILabel!
    @IBOutlet weak var pointButton: UIButton!
    
    /*func setLabel() { -- function example for IBOutlet Label
        scoringLabel.text = "\(winScore)"
    }*/

    
   @IBAction func pointButtonPressed(_ sender: Any) {
    //delegate?.didTappedButton(index: (index?.row)!) -- Delegate needed for protocols
        winScore += 1
        scoreUILabel.text = "\(winScore)"
 
    }
    
}

