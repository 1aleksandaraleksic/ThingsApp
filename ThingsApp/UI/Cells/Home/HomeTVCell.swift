//
//  HomeTVCell.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import UIKit

protocol HomeTVCellDelegate{
    func selectedCell(isSelected: Bool, episodeId: Int?)
}

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!

    var delegate: HomeTVCellDelegate?
    private var episodeId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionImageView.isHidden = true
    }

    func setupCell(episodeId: Int?, title: String?, delegate: HomeTVCellDelegate?){
        self.episodeId = episodeId
        titleLabel.text = title
        self.delegate = delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectionImageView.isHidden = false
        } else {
            selectionImageView.isHidden = true
        }
        self.delegate?.selectedCell(isSelected: selected, episodeId: self.episodeId)
    }
    
}
