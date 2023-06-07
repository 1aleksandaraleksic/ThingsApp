//
//  FooterView.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

protocol FooterViewDelegate{
    func didTapFooterButton()
}

class FooterView: BaseView {

    var delegate: FooterViewDelegate?

    init(layerShapePositon: LayerShapePositon = .footerRight, frame: CGRect, delegate: FooterViewDelegate){
        super.init(frame: frame)
        self.delegate = delegate
        self.layerShapePosition = layerShapePositon
        addButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layerShapePosition = .footerRight
        addButton()
    }


    func addButton(){
        let title = self.layerShapePosition == .footerRight ? messages?.home?.buttonTitle : messages?.detail?.buttonTitle
        let xPosition = self.layerShapePosition == .footerRight ? DeviceScreen.width - 170 : 10
        let button = UIButton(frame: CGRect(x: xPosition, y: 100, width: 150, height: 35))
        button.setAttributedTitle((title ?? "").toAttributedString(size: 20, color: UIColor.white, isBold: true),
                                  for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(didTapFooterButton), for: .touchUpInside)
        self.addSubview(button)
    }

    @objc public func didTapFooterButton(){
        self.delegate?.didTapFooterButton()
    }

}
