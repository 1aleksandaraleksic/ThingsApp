//
//  DetailHeaderTVCell.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 8.6.23..
//

import UIKit

class DetailHeaderTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chosenTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(cellTitle: String?, chosenTitle: String?){
        titleLabel.text = cellTitle
        chosenTitleLabel.text = chosenTitle
    }
}
