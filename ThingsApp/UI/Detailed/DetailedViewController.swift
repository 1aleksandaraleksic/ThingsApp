//
//  DetailedViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import UIKit

class DetailedViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setupUI() {
        mainTableView.widthAnchor.constraint(equalToConstant: DeviceScreen.width / 2).isActive = true

        let footerView = FooterView(layerShapePositon: .footerLeft,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 180, width: DeviceScreen.width, height: 150), delegate: self)
        self.view.addSubview(footerView)
        self.view.backgroundColor = .gray
    }

}

extension DetailedViewController: UITableViewDelegate {

}

extension DetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}

extension DetailedViewController: FooterViewDelegate {
    func didTapFooterButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
