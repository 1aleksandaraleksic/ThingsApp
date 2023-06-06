//
//  BaseViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit

enum HomeTableSection: Int, CaseIterable {
    case header = 0
    case content = 1
    case footer = 2
}

class BaseViewController: UIViewController, BaseProtocol {

    var homeViewModel: HomeViewModel?
    var homeSections: [HomeTableSection] = [.header]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        setupUI()
    }

    func setupUI() {

    }

}
