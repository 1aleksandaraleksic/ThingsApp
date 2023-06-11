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
    private var episodeId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        selectionStyle = .none
        selectionImageView.isHidden = true
        selectionImageView.tintColor = .white
        titleLabel.textColor = .white
        commentView.isHidden = true
    }

    func setupCell(episode: Result?, titleSize: CGFloat?, delegate: HomeTVCellDelegate?){
        self.episodeId = episode?.id
        titleLabel.text = episode?.name
        setComment(comment: episode?.comment)
        titleLabel.font = .boldSystemFont(ofSize: titleSize ?? 0)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectionImageView.isHidden = false
        } else {
            selectionImageView.isHidden = true
        }
        self.delegate?.selectedCell(isSelected: selected, episodeId: self.episodeId)
    }

    public func getEpisodeId() -> Int? {
        return episodeId
    }
}
