//
//  String+Extension.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

extension String {

    func toAttributedString(size: CGFloat = 14, color: UIColor = UIColor.black, isBold: Bool = false) -> NSAttributedString{
        let systemFont = isBold ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
        let myAttribute = [ NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: systemFont ]
        let myAttrString = NSAttributedString(string: self, attributes: myAttribute as [NSAttributedString.Key : Any])
        return myAttrString
    }
}
