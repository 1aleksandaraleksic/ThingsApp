//
//  Contstants.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import Foundation

class Constants {

    public static var baseUrl = "https://rickandmortyapi.com/api/"
    
    /**
    Url by default will return first page of episodes, if you need specific page just pass number of page as Int value
    */
    public static func getRickAndMortyEpisodes(_ page: Int = 0) -> String{
        let episodeUrl = baseUrl + "episode"
        return page == 0 ? episodeUrl : episodeUrl + "/?page=\(page)"
    }

    /**
    Url by default will return character with id 1
    */
    public static func getRickAndMortyCharacter(_ ids: String = "1") -> String{
        return baseUrl + "character/\(ids)"
    }

    public enum Storyboard: String {
        case main = "Main"
    }

    public enum ViewControllers: String {
        case homeVC = "HomeViewController"
        case detailedVC = "DetailedViewController"
    }

    public enum TableViewCellNames: String {
        case homeTVCell = "HomeTVCell"
        case characterTVCell = "CharacterTVCell"
        case detailHeaderTVCell = "DetailHeaderTVCell"
    }

    public enum images: String {
        case checkmarkCircle = "checkmark.circle.fill"
    }
}
