//
//  TstTableViewCell.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/30.
//

import UIKit

class TstTableViewCell: UITableViewCell {
    @IBOutlet weak var testLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
