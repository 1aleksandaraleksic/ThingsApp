//
//  DetailedViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import UIKit
import Toast

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
        viewModel?.convertParameters(parameters: parameters){ isAvailable in
            if isAvailable{
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }
    }

    override func setupUI(_ parameters: [Constants.ParametersVariabile : Any]?) {
        mainTableView.widthAnchor.constraint(equalToConstant: DeviceScreen.width / 2).isActive = true
        mainTableView.register(UINib(nibName: Constants.TableViewCellNames.homeTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue)

        detaildTableView.register(UINib(nibName: Constants.TableViewCellNames.characterTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.characterTVCell.rawValue)
        detaildTableView.register(UINib(nibName: Constants.TableViewCellNames.detailHeaderTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.detailHeaderTVCell.rawValue)
        detaildTableView.layer.cornerRadius = 10
        detaildTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        footerView = FooterView(layerShapePositon: .footerLeft,
                                    isButtonEnabled: true,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 150, width: DeviceScreen.width, height: 150), delegate: self)
        view.addSubview(footerView ?? UIView())
    }

}

extension DetailedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTVCell{
            if let id = viewModel?.filteredEpisodes?[indexPath.row].id {
                cell.selectCell(selected: true, episodeId: id)
            }
        }
    }

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
                if let episode = viewModel?.filteredEpisodes?[indexPath.row]{
                    cell.setupUI([.episode: episode,
                                  .titleSize: CGFloat(14),
                                  .isAtHome: false,
                                  .delegate: self])
                    cell.setGradientColor(position: indexPath.row, total: viewModel?.filteredEpisodes?.count ?? 0)
                }
                return cell
            }
        case detaildTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.characterTVCell.rawValue) as? CharacterTVCell{
                let character = viewModel?.charactersOfChosenEpisode?[indexPath.row]
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
        return 60
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == mainTableView {
            if indexPath.row == 0 {
                footerView?.stopLoader()
            }
        } else if tableView == detaildTableView {
            if indexPath.row == 0 {
                detaildTableView.addAnimationRotatation(repeatCount: 1)
            }
        }
    }

}

extension DetailedViewController: FooterViewDelegate {
    func didTapFooterButton() {
        navigationController?.popToRootViewController(animated: true)
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
            footerView?.stopLoader()
        }
    }

}

extension DetailedViewController: DetailedViewModelDelegate {
    func fetchedCharacter(isArrived: Bool, errorMessage: String?) {
        if isArrived {
            detaildTableView.reloadData()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                self.detaildTableView.reloadData()
            }
        } else {
            view.makeToast(errorMessage, duration: 1.0, position: .bottom)
        }
        footerView?.stopLoader()
    }
}
