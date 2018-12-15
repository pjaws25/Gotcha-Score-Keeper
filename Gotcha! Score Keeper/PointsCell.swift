//
//  PointsCell.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 12/6/18.
//  Copyright © 2018 Peter Jaworski. All rights reserved.
//

import UIKit

/*protocol ScoreCellDelegate {
    func didTappedButton (index: Int)
}*/

class PointsCell: UITableViewCell {
    
   // var delegate : ScoreCellDelegate?
   // var index : IndexPath?
    var winScore = 0
    @IBOutlet weak var scoreUILabel: UILabel!
    @IBOutlet weak var pointButton: UIButton!
    
    /*func viewDidLoad() {
        scoringLabel.text = "\(winScore)"
    }*/
    
    func setLabel(){
        scoreUILabel.text = "\(winScore)"
    }
    
   @IBAction func pointButtonPressed(_ sender: Any) {
    //delegate?.didTappedButton(index: (index?.row)!)
        winScore += 1
        scoreUILabel.text = "\(winScore)"
 
    }
    
}


    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PointsCell
        
        cell.textLabel?.text = "it works!"
        
        return cell
    }
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

        override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
