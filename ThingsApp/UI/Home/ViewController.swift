//
//  ViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainTableView.register(UINib(nibName: "HeaderTVCell", bundle: nil), forCellReuseIdentifier: "HeaderTVCell")
        mainTableView.register(UINib(nibName: "FooterTVCell", bundle: nil), forCellReuseIdentifier: "FooterTVCell")
    }

    override func setupUI() {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 150))
        self.view.addSubview(headerView)
        let footerView = FooterView(layerShapePositon: .footerRight,
                                    frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 150))
        self.view.addSubview(footerView)
        self.view.backgroundColor = .gray
    }


}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//                if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVCell") as? HeaderTVCell{
//
//                    return cell
//                }
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.black.withAlphaComponent(0)


        return cell
    }


}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
