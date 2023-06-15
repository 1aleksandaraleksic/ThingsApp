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
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentLabel: UILabel!

    var delegate: HomeTVCellDelegate?
    private var episodeIsSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        selectionStyle = .none
        selectionImageView.isHidden = episodeIsSelected
        selectionImageView.tintColor = .white
        titleLabel.textColor = .white
        commentView.isHidden = true
    }

    func setupCell(episode: Result?, titleSize: CGFloat?, isAtHome: Bool = true, delegate: HomeTVCellDelegate){
        if isAtHome {
            if let selected = episode?.isSelected{
                episodeIsSelected = selected
                selectionImageView.isHidden = !selected
            }
        } else {
            selectionImageView.isHidden = true
        }
        titleLabel.text = episode?.name
        titleLabel.font = .boldSystemFont(ofSize: titleSize ?? 0)
        setComment(comment: episode?.comment)
        self.delegate = delegate
    }

    private func setComment(comment: String?){
        if let comment = comment {
            commentView.isHidden = false
            commentLabel.text = comment
        } else {
            commentView.isHidden = true
        }
    }

    func setGradientColor(position: Int, total: Int){
        let alpha = CGFloat(1 - (CGFloat(position) / CGFloat(total)))
        containerView.backgroundColor = .primaryGreen().withAlphaComponent(alpha)
    }

    func selectCell(selected: Bool, episodeId: Int?){
        episodeIsSelected = selected
        delegate?.selectedCell(isSelected: selected, episodeId: episodeId)
    }

}
