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

class HomeTVCell: BaseTVCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentLabel: UILabel!

    var delegate: HomeTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        selectionStyle = .none
        selectionImageView.tintColor = .white
        titleLabel.textColor = .white
        commentView.isHidden = true
    }

    override func setupUI(_ parameters: [Constants.ParametersVariabile: Any]?) {
        self.parameters = parameters
        guard let episode = getObject(Result.self, parameterName: .episode),
              let titleSize = getObject(CGFloat.self, parameterName: .titleSize),
              let delegate = getObject(HomeTVCellDelegate.self, parameterName: .delegate)
        else {
            return
        }

        if let isAtHome = getObject(Bool.self, parameterName: .isAtHome), isAtHome {
            selectionImageView.isHidden = !episode.isSelected
        } else {
            selectionImageView.isHidden = true
        }
        titleLabel.text = episode.name
        titleLabel.font = .boldSystemFont(ofSize: titleSize)
        setComment(comment: episode.comment)
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
        selectionImageView.isHidden = !selected
        delegate?.selectedCell(isSelected: selected, episodeId: episodeId)
    }

}
