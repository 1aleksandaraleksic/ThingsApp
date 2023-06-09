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

    private var button: UIButton?
    private var loaderImageView: UIImageView?

    var delegate: FooterViewDelegate?

    init(layerShapePositon: LayerShapePositon = .footerRight, isButtonEnabled: Bool, frame: CGRect, delegate: FooterViewDelegate){
        super.init(frame: frame)
        self.delegate = delegate
        self.layerShapePosition = layerShapePositon
        addButton(enabled: isButtonEnabled)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    private func addButton(enabled: Bool){
        let title = self.layerShapePosition == .footerRight ? messages?.home?.buttonTitle : messages?.detail?.buttonTitle
        let xPosition = self.layerShapePosition == .footerRight ? DeviceScreen.width - 170 : 20
        button = UIButton(frame: CGRect(x: xPosition, y: 80, width: 150, height: 35))
        button?.setAttributedTitle((title ?? "").toAttributedString(size: 20, color: .white, isBold: true),
                                  for: .normal)
        button?.backgroundColor = .primaryBlue()
        button?.addTarget(self, action: #selector(didTapFooterButton), for: .touchUpInside)
        button?.isEnabled = enabled
        button?.layer.cornerRadius = 5
        self.addSubview(button ?? UIView())
    }

    private func addLoader(){
        loaderImageView = UIImageView(frame: CGRect(x: self.layerShapePosition == .footerRight ? 20 : DeviceScreen.width - 180,
                                                    y: 0,
                                                    width: 180,
                                                    height: 90))
        loaderImageView?.image = UIImage(named: Constants.images.titleRAndM.rawValue)
        self.addSubview(loaderImageView ?? UIView())
        startLoader()
    }

    @objc private func didTapFooterButton(){
        self.delegate?.didTapFooterButton()
    }

    public func startLoader(){
        loaderImageView?.addAnimationRotatation()
    }

    public func stopLoader(){
        loaderImageView?.layer.removeAllAnimations()
    }

    public func isButtonEnabled(enabled: Bool){
        button?.isEnabled = enabled
    }
}
