//
//  DetailedViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import UIKit

class DetailedViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var containerDetailView: UIView!
    @IBOutlet weak var detaildTableView: UITableView!

    public var viewModel: DetailedViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailedViewModel(delegate: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.convertParameters(parameters: parameters){isAvailable in
            if isAvailable{
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }
    }

    override func setupUI() {
        mainTableView.widthAnchor.constraint(equalToConstant: DeviceScreen.width / 2).isActive = true
        mainTableView.register(UINib(nibName: Constants.TableViewCellNames.homeTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue)

        detaildTableView.register(UINib(nibName: Constants.TableViewCellNames.characterTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.characterTVCell.rawValue)
        detaildTableView.register(UINib(nibName: Constants.TableViewCellNames.detailHeaderTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.detailHeaderTVCell.rawValue)

        footerView = FooterView(layerShapePositon: .footerLeft,
                                    isButtonEnabled: true,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 180, width: DeviceScreen.width, height: 150), delegate: self)
        self.view.addSubview(footerView ?? UIView())
        self.view.backgroundColor = .gray
    }

}

extension DetailedViewController: UITableViewDelegate {

}

extension DetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case mainTableView:
            return viewModel?.filteredEpisodes?.count ?? 0
        case detaildTableView:
            return viewModel?.charactersOfChosenEpisode?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == detaildTableView {
            if let total = viewModel?.charactersOfChosenEpisode?.count{
                //MARK: height for header in detaildTableView
                return total == 0 ? 0.0 : 80.0
            }
        }
        return 0.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == detaildTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.detailHeaderTVCell.rawValue) as? DetailHeaderTVCell{
                cell.setupCell(cellTitle: messages?.detail?.selectedDetailTitle, chosenTitle: viewModel?.chosenEpisode?.name)
                return cell
            }
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case mainTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue) as? HomeTVCell{
                let episode = viewModel?.filteredEpisodes?[indexPath.row]
                cell.setupCell(episodeId: episode?.id, title: episode?.name, delegate: self)
                return cell
            }
        case detaildTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.characterTVCell.rawValue) as? CharacterTVCell{
                let character = self.viewModel?.charactersOfChosenEpisode?[indexPath.row]
                cell.setupCell(title: character?.name, imageUrl: character?.image)
                return cell
            }
        default:
            return UITableViewCell()
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == detaildTableView {
            return 120
        }
        return 50
    }


}

extension DetailedViewController: FooterViewDelegate {
    func didTapFooterButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension DetailedViewController: HomeTVCellDelegate {
    func selectedCell(isSelected: Bool, episodeId: Int?) {
        if isSelected {
            viewModel?.chosenEpisode(id: episodeId)
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                self.detaildTableView.reloadData()
            }
        } else {
            self.footerView?.stopLoader()
        }
    }

}

extension DetailedViewController: DetailedViewModelDelegate {
    func fetchedCharacter(isArrived: Bool) {
        if isArrived {
            self.footerView?.stopLoader()
            self.detaildTableView.reloadData()
        } else {
            self.footerView?.startLoader()
        }
    }

}
