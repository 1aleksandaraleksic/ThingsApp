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
    private var button: UIButton?

    init(layerShapePositon: LayerShapePositon = .footerRight, isButtonEnabled: Bool, frame: CGRect, delegate: FooterViewDelegate){
        super.init(frame: frame)
        self.delegate = delegate
        self.layerShapePosition = layerShapePositon
        addButton(enabled: isButtonEnabled)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layerShapePosition = .footerRight
        addButton(enabled: false)
    }


    func addButton(enabled: Bool){
        let title = self.layerShapePosition == .footerRight ? messages?.home?.buttonTitle : messages?.detail?.buttonTitle
        let xPosition = self.layerShapePosition == .footerRight ? DeviceScreen.width - 170 : 10
        button = UIButton(frame: CGRect(x: xPosition, y: 100, width: 150, height: 35))
        button?.setAttributedTitle((title ?? "").toAttributedString(size: 20, color: UIColor.white, isBold: true),
                                  for: .normal)
        button?.backgroundColor = .green
        button?.addTarget(self, action: #selector(didTapFooterButton), for: .touchUpInside)
        button?.isEnabled = enabled
        self.addSubview(button ?? UIView())
    }

    @objc public func didTapFooterButton(){
        self.delegate?.didTapFooterButton()
    }

    public func isButtonEnabled(enabled: Bool){
        button?.isEnabled = enabled
    }
}
