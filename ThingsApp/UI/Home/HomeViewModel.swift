//
//  HomeViewModel.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import Foundation

protocol HomeViewModelDelegate {
    func data(isFetched: Bool)
    func buttonAvailability(isEnabled: Bool)
    func editEpisode(title: String?, id: Int?)
}

class HomeViewModel {

    public var episodes: EpisodesResponse?
    public var selectedEpisodes: [Result]?
    private var numberOfSelectedCells: Int = 0 {
        willSet (newValue){
            isButtonEnabled = newValue >= 3 ? true : false
        }
    }
    public var isButtonEnabled: Bool = false {
        willSet (newValue) {
            delegate?.buttonAvailability(isEnabled: newValue)
        }
    }

    var delegate: HomeViewModelDelegate?

    init(delegate: HomeViewModelDelegate){
        self.delegate = delegate
        getEpisodes()
        selectedEpisodes = []
    }

    func getEpisodes() {
        ApiManager.shared.fetchEpisodes { episodes in
            self.episodes = episodes
            self.delegate?.data(isFetched: true)
        } fail: { error in
            self.delegate?.data(isFetched: false)
        }
    }

    func addEpisode(id: Int?){
        if let id = id {
            if let episode = episodes?.results?.first(where: {$0.id == id}){
                selectedEpisodes?.append(episode)
                cellIsSelected()
            }
        }
    }

    func removeEpisode(id: Int?){
        if let id = id {
            if let index = selectedEpisodes?.firstIndex(where: {$0.id == id}) {
                selectedEpisodes?.remove(at: index)
                cellIsDeselected()
            }
        }
    }

    private func cellIsSelected(){
        numberOfSelectedCells += 1
    }

    private func cellIsDeselected(){
        numberOfSelectedCells -= 1
    }

    func editEpisode(episodeId: Int?){
        if let episode = getEpisode(id: episodeId){
            self.delegate?.editEpisode(title: episode.name, id: episode.id)
            return
        }
        self.delegate?.editEpisode(title: nil, id: nil)
    }

    func commentEpisode(text: String?, episodeId: Int?, isEdited: @escaping ((Bool) -> Void)){
        if let episode = getEpisode(id: episodeId){
            episode.comment = text
            isEdited(true)
        } else {
            isEdited(false)
        }
    }

    func removeCommentFromEpisode(episodeId: Int?, isRemoved: @escaping ((Bool) -> Void)){
        if let episode = getEpisode(id: episodeId){
            episode.comment = nil
            isRemoved(true)
        } else {
            isRemoved(false)
        }
    }

    private func getEpisode(id: Int?) -> Result?{
        if let episode = episodes?.results?.first(where: {$0.id == id}){
            return episode
        }
        return nil
    }
    
}
