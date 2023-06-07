//
//  Contstants.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import Foundation

class Constants {

    public enum RickAndMortyApi: String {
        case episode = "https://rickandmortyapi.com/api/episode"
        case character = "https://rickandmortyapi.com/api/character"
    }
    
    /**
    Url by default will return first page of episodes, if you need specific page just pass number of page as Int value
    */
    public static func getRickAndMortyEpisodes(_ page: Int = 0) -> String{
        let episodeUrl = "https://rickandmortyapi.com/api/episode"
        return page == 0 ? episodeUrl : episodeUrl + "/?page=\(page)"
    }

    public enum TableViewCellNames: String {
        case homeTVCell = "HomeTVCell"
    }

    public enum images: String {
        case checkmarkCircle = "checkmark.circle.fill"
    }
}
