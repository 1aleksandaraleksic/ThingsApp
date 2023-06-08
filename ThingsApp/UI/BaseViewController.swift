//
//  BaseViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit

class BaseViewController: UIViewController, BaseProtocol {

    var parameters: [Any]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let headerView = HeaderView(frame: CGRect(x: 0, y: 50, width: DeviceScreen.width, height: 150))
        self.view.addSubview(headerView)
        setupUI()
    }

    func setupUI() {

    }

}
