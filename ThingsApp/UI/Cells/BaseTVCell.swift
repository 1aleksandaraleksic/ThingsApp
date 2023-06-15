//
//  BaseTVCell.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 15.6.23..
//

import UIKit
import Foundation

class BaseTVCell: UITableViewCell, BaseProtocol {
    internal var parameters: [Constants.ParametersVariabile: Any]?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupUI(_ parameters: [Constants.ParametersVariabile: Any]?) {
        
    }

    func getObject<T>(_ type: T.Type, parameterName: Constants.ParametersVariabile?) -> T? {
        if let param = parameterName,
           let obj = parameters?[param] {
            return obj as? T
        }
        return nil
    }

}
