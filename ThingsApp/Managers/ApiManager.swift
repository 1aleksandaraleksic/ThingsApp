//
//  ApiManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import Foundation

class ApiManager {
    
    public static let shared = ApiManager()

    func fetchEpisodes(page: Int,
                       success: @escaping ((EpisodesResponse) -> Void),
                       fail: @escaping ((RequestError) -> Void)) {
        
        ServiceManager.shared.invoke(url: Constants.getRickAndMortyEpisodes(page),
                                     method: .get,
                                     model: EpisodesResponse.self) { response in
            success(response)
        } fail: { error in
            fail(error)
        }
    }

    func fetchCharacters(ids: String = "1",
                         success: @escaping (([CharacterResponse]) -> Void),
                         fail: @escaping ((RequestError) -> Void)) {

        ServiceManager.shared.invoke(url: Constants.getRickAndMortyCharacter(ids),
                                     method: .get,
                                     model: [CharacterResponse].self) { response in
            success(response)
        } fail: { error in
            fail(error)
        }
    }

    func fetchImage(url: String,
                    success: @escaping ((Data) -> Void),
                    fail: @escaping ((RequestError) -> Void)){
        ServiceManager.shared.downloadImage(url: url) { data in
            success(data)
        } fail: { error in
            fail(.unknown)
        }
    }
}
