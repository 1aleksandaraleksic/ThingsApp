//
//  HomeViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!

    private var homeViewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(delegate: self)
    }

    override func setupUI() {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 50, width: DeviceScreen.width, height: 150))
        self.view.addSubview(headerView)
        let footerView = FooterView(layerShapePositon: .footerRight,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 180, width: DeviceScreen.width, height: 150))
        self.view.addSubview(footerView)
        self.view.backgroundColor = .gray

        mainTableView.register(UINib(nibName: Constants.TableViewCellNames.homeTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue)
    }


}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.episodes?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

                if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue) as? HomeTVCell{
                    cell.setupCell(title: homeViewModel?.episodes?.results?[indexPath.row].name)
                    return cell
                }
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.black.withAlphaComponent(0)


        return cell
    }


}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func data(isFetched: Bool) {
        if isFetched {
            self.mainTableView.reloadData()
        } else {
            //TODO: show alert with message data not available
        }
    }

}
