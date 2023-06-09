//
//  DetailedViewModel.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 8.6.23..
//

import Foundation

protocol DetailedViewModelDelegate {
    func fetchedCharacter(isArrived: Bool)
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
        ApiManager.shared.fetchCharacters(ids: getCharactersId()) {[weak self] characters in
            self?.charactersOfChosenEpisode = characters
            self?.delegate?.fetchedCharacter(isArrived: true)
        } fail: {[weak self] error in
            print("ERROR fetching characters: ", error)
            self?.delegate?.fetchedCharacter(isArrived: false)
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
