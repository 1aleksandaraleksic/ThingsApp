//
//  HomeViewModel.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import Foundation

protocol HomeViewModelDelegate {
    func data(isFetched: Bool)
}

class HomeViewModel {

    public var episodes: EpisodesResponse?

    var delegate: HomeViewModelDelegate?

    init(delegate: HomeViewModelDelegate){
        self.delegate = delegate
        getEpisodes()
    }

    func getEpisodes() {
        ApiManager.shared.fetchEpisodes { episodes in
            self.episodes = episodes
            self.delegate?.data(isFetched: true)
        } fail: { error in
            print(error)
            self.delegate?.data(isFetched: false)
        }
    }
}
