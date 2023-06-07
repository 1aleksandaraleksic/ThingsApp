//
//  HomeTVCell.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import UIKit

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionImageView.isHidden = true
    }

    func setupCell(title: String?){
        titleLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectionImageView.isHidden = false
        } else {
            selectionImageView.isHidden = true
        }
    }
    
}
