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
        footerView = FooterView(layerShapePositon: .footerRight,
                                    isButtonEnabled: homeViewModel?.isButtonEnabled ?? false,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 180, width: DeviceScreen.width, height: 150), delegate: self)
        self.view.addSubview(footerView ?? UIView())
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
            let episode = homeViewModel?.episodes?.results?[indexPath.row]
            cell.setupCell(episodeId: episode?.id, title: episode?.name, delegate: self)
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

    func buttonAvailability(isEnabled: Bool) {
        self.footerView?.isButtonEnabled(enabled: isEnabled)
    }

}

extension HomeViewController: FooterViewDelegate {
    func didTapFooterButton() {
        let storyBoard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllers.detailedVC.rawValue) as? DetailedViewController {
            vc.parameters = self.homeViewModel?.selectedEpisodes
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: HomeTVCellDelegate {
    func selectedCell(isSelected: Bool, episodeId: Int?) {
        if isSelected {
            self.homeViewModel?.addEpisode(id: episodeId)
        } else {
            self.homeViewModel?.removeEpisode(id: episodeId)
        }
    }
}
