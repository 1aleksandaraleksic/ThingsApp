//
//  DetailedViewModel.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 8.6.23..
//

import Foundation

protocol DetailedViewModelDelegate {
    func fetchedCharacter(isArrived: Bool, errorMessage: String?)
    func loading(isFinished: Bool)
}

class DetailedViewModel {

    private var selectedEpisodes: [Result]? = []
    public var filteredEpisodes: [Result]? = []
    public var chosenEpisode: Result?
    public var charactersOfChosenEpisode: [CharacterResponse]?

    private var delegate: DetailedViewModelDelegate?

    init(delegate: DetailedViewModelDelegate){
        self.delegate = delegate
    }

    func convertParameters(parameters: [Any]?, isAvailable: @escaping ((Bool) -> Void)){
        if let episodes = parameters as? [Result]{
            selectedEpisodes = episodes
            filteredEpisodes = episodes
            return isAvailable(true)
        }
        isAvailable(false)
    }

    func getCharacters(){
        self.delegate?.loading(isFinished: false)
        ApiManager.shared.fetchCharacters(ids: getCharactersId()) {[weak self] characters in
            self?.charactersOfChosenEpisode = characters
            self?.delegate?.loading(isFinished: true)
            self?.delegate?.fetchedCharacter(isArrived: true, errorMessage: nil)
        } fail: {[weak self] error in
            self?.delegate?.loading(isFinished: false)
            self?.delegate?.fetchedCharacter(isArrived: false, errorMessage: "ERROR fetching characters: \(error)")
        }

    }

    func chosenEpisode(id: Int?){
        if let episode = selectedEpisodes?.first(where: {$0.id == id}){
            chosenEpisode = episode
            getCharacters()
            hideSelectedEpisode()
        }
    }

    private func getCharactersId() -> String{
        var ids: String = ""
        chosenEpisode?.characters?.forEach({ character in
            if let id = Int(character.replacingOccurrences(of: "https://rickandmortyapi.com/api/character/", with: "")){
                ids += character == chosenEpisode?.characters?.last ? "\(id)" : "\(id),"
            }
        })
        return ids
    }

    private func hideSelectedEpisode(){
        filteredEpisodes = selectedEpisodes
        if let episode = chosenEpisode{
            if let index = filteredEpisodes?.firstIndex(of: episode) {
                filteredEpisodes?.remove(at: index)
            }
        }
    }

}
