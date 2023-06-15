//
//  CharacterTVCell.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 8.6.23..
//

import UIKit
import Alamofire

class CharacterTVCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .primaryGreen()
    }

    func setupCell(title: String?, imageUrl: String?){
        titleLabel.text = title
        if let url = imageUrl {
            ApiManager.shared.fetchImage(url: url) {[weak self] data in
                self?.profileImageView.image = UIImage(data: data)
            } fail: { error in
                print("ERROR fetching image: ", error)
            }
        }
    }

    
    
}
