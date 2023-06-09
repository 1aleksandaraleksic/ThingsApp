//
//  HeaderView.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

class HeaderView: BaseView {

    private var logoImageView: UIImageView?

    init(layerShapePositon: LayerShapePositon = .headerLeft, frame: CGRect){
        super.init(frame: frame)
        self.layerShapePosition = layerShapePositon
        addTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func addTitle(){
        self.addSubview(createTitleLabel(text: messages?.home?.title, size: 28, x: 15, y: 50))
        self.addSubview(createTitleLabel(text: messages?.home?.subtitle, size: 22, x: 15, y: 80))
    }

    private func createTitleLabel(text: String?, size: CGFloat, x: Int, y: Int) -> UILabel{
        let label = UILabel(frame: CGRect(x: x, y: y, width: 150, height: 30))
        label.attributedText = text?.toAttributedString(size: size, color: UIColor.white, isBold: true)
        return label
    }

    private func createImageView(){
        logoImageView = UIImageView(frame: CGRect(x: (DeviceScreen.width - 120), y: 45, width: 120, height: 80))
        logoImageView?.image = UIImage(named: Constants.images.logoRAndM.rawValue)
        self.addSubview(logoImageView ?? UIView())
    }

    public func animateLogo(){
        createImageView()
        logoImageView?.addAnimationWiggle()
    }

    public func removeAnimateLogo(){
        for v in self.subviews{
            if v.isKind(of: UIImageView.self) {
                v.removeFromSuperview()
            }
        }
    }

}
