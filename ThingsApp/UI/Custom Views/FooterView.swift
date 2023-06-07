//
//  FooterView.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

class FooterView: BaseView {

    init(layerShapePositon: LayerShapePositon = .footerRight, frame: CGRect){
        super.init(frame: frame)
        self.layerShapePosition = layerShapePositon
        addButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layerShapePosition = .footerRight
        addButton()
    }


    func addButton(){
        let button = UIButton(frame: CGRect(x: DeviceScreen.width - 170, y: 100, width: 150, height: 30))
        button.setAttributedTitle("next".toAttributedString(size: 20, color: UIColor.white, isBold: true),
                                  for: .normal)
        self.addSubview(button)
    }

}
