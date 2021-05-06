//
//  PickupLineTableViewCell.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/04.
//

import UIKit

class PickupLineTableViewCell: UITableViewCell {

    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(with pickupLine: PickupLine) {
        lineLabel?.text = pickupLine.line
        scoreLabel.text = pickupLine.scoreString() ?? ""
        emailLabel.text = pickupLine.email ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
