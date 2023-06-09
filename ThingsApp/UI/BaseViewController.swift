//
//  BaseViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit

class BaseViewController: UIViewController, BaseProtocol {

    var parameters: [Any]? = []

    var headerView: HeaderView?
    var footerView: FooterView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: DeviceScreen.width, height: 150))
        view.addSubview(headerView ?? UIView())
        headerView?.animateLogo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView?.removeAnimateLogo()
    }

    func setupUI() {

    }

}
