//
//  HomeViewController.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import UIKit
import Toast

class HomeViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var containerInputView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputLabel: UILabel!

    private var homeViewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel(delegate: self)
    }

    override func setupUI() {
        footerView = FooterView(layerShapePositon: .footerRight,
                                    isButtonEnabled: homeViewModel?.isButtonEnabled ?? false,
                                    frame: CGRect(x: 0, y: DeviceScreen.height - 150, width: DeviceScreen.width, height: 150),
                                delegate: self)
        view.addSubview(footerView ?? UIView())

        mainTableView.register(UINib(nibName: Constants.TableViewCellNames.homeTVCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue)
        containerInputView.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        headerView = nil
    }

    @IBAction func confirmButtonTapped(_ sender: Any) {
        homeViewModel?.commentEpisode(text: inputTextField.text, episodeId: inputTextField.tag){ [weak self] isEdited in
            if isEdited{
                self?.containerInputView.isHidden = true
                self?.mainTableView.reloadData()
            }
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        homeViewModel?.removeCommentFromEpisode(episodeId: inputTextField.tag){[weak self] isRemoved in
            if isRemoved {
                self?.containerInputView.isHidden = true
                self?.mainTableView.reloadData()
            }
        }
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel?.episodes?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.homeTVCell.rawValue) as? HomeTVCell{
            let episode = homeViewModel?.episodes?.results?[indexPath.row]
            cell.setupCell(episode: episode, titleSize: 17, delegate: self)
            cell.setGradientColor(position: indexPath.row,
                                  total: homeViewModel?.episodes?.results?.count ?? 0)
            inputTextField.text = episode?.comment
            return cell
        }
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.black.withAlphaComponent(0)


        return cell
    }


}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeTVCell{
            if let ep = homeViewModel?.episodes?.results?[indexPath.row]{
                //MARK: visual effect to highlight selected cell
                tableView.reloadRows(at: [indexPath], with: .automatic)
                cell.selectCell(selected: !ep.isSelected, episodeId: homeViewModel?.episodes?.results?[indexPath.row].id)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let commentAction = UIContextualAction(style: .normal, title: "Comment") {[weak self] (action, view, handler) in
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self?.homeViewModel?.editEpisode(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        commentAction.backgroundColor = .black.withAlphaComponent(0.01)

        let configuration = UISwipeActionsConfiguration(actions: [commentAction])
        return configuration
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == homeViewModel?.episodes?.results?.count {
            homeViewModel?.getEpisodes()
        }
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func data(isFetched: Bool, errorMessage: String?) {
        if isFetched {
            mainTableView.reloadData()
        } else {
            view.makeToast(errorMessage, duration: 1.0, position: .bottom)
        }
    }

    func buttonAvailability(isEnabled: Bool) {
        footerView?.isButtonEnabled(enabled: isEnabled)
    }

    func editEpisode(title: String?, id: Int?) {
        if let title = title, let id = id {
            inputLabel.text = title
            inputTextField.tag = id
            containerInputView.isHidden = false
        }
    }

    func loading(isFinished: Bool) {
        isFinished ? footerView?.stopLoader() : footerView?.startLoader()
    }

}

extension HomeViewController: FooterViewDelegate {
    func didTapFooterButton() {
        let storyBoard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Constants.ViewControllers.detailedVC.rawValue) as? DetailedViewController {
            vc.parameters = homeViewModel?.selectedEpisodes
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: HomeTVCellDelegate {
    func selectedCell(isSelected: Bool, episodeId: Int?) {
        if isSelected {
            homeViewModel?.addEpisode(id: episodeId)
        } else {
            homeViewModel?.removeEpisode(id: episodeId)
        }
        mainTableView.reloadData()
    }
}
