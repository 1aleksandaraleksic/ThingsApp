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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!

    var delegate: HomeTVCellDelegate?
    private var episodeId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        selectionStyle = .none
        selectionImageView.isHidden = true
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 17)
        selectionImageView.tintColor = .white
    }

    func setupCell(episodeId: Int?, title: String?, delegate: HomeTVCellDelegate?){
        self.episodeId = episodeId
        titleLabel.text = title
        self.delegate = delegate
    }

    func setGradientColor(position: Int, total: Int){
        let alpha = CGFloat(1 - (CGFloat(position) / CGFloat(total)))
        containerView.backgroundColor = .primaryGreen().withAlphaComponent(alpha)
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
