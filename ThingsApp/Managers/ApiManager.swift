//
//  ApiManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import Foundation

class ApiManager {
    
    public static let shared = ApiManager()

    func fetchEpisodes(success: @escaping ((EpisodesResponse) -> Void),
                       fail: @escaping ((RequestError) -> Void)) {
        
        ServiceManager.shared.invoke(url: Constants.getRickAndMortyEpisodes(),
                                     method: .get,
                                     model: EpisodesResponse.self) { response in
            success(response)
        } fail: { error in
            fail(error)
        }
    }
}
