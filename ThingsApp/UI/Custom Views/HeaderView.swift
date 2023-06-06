//
//  HeaderView.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

class HeaderView: BaseView {

    init(layerShapePositon: LayerShapePositon = .headerLeft, frame: CGRect){
        super.init(frame: frame)
        self.layerShapePosition = layerShapePositon
        addTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layerShapePosition = .headerLeft
        addTitle()
    }

    func addTitle(){
        let label = UILabel(frame: CGRect(x: 15, y: 20, width: 150, height: 30))
        label.attributedText = messages?.home?.title?.toAttributedString(size: 28, color: UIColor.white, isBold: true)

        let label2 = UILabel(frame: CGRect(x: 15, y: 55, width: 150, height: 30))
        label2.attributedText = messages?.home?.subtitle?.toAttributedString(size: 22, color: UIColor.white, isBold: true)

        self.addSubview(label)
        self.addSubview(label2)
    }

}
