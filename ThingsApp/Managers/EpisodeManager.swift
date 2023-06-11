//
//  EpisodeManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 12.6.23..
//

import Foundation
import CoreData

class EpisodeManager {

    static var shared = EpisodeManager()

    public func saveEpisodeComment(comment: String?, id: Int?) -> Bool{
        if let id = id {
            if CoreDataManager.shared.saveEpisode(id: id, text: comment) ?? false {
                return true
            }
        }
        return false
    }

    public func deleteEpisodeComment(id: Int?) -> Bool{
        if let id = id {
            if CoreDataManager.shared.deleteEpisode(id: id) ?? false {
                return true
            }
        }
        return false
    }

    public func getAllSavedEpisode() -> [BasicEpisode]?{
        if let coreData = CoreDataManager.shared.loadSavedEpisodes(){
            var array: [BasicEpisode] = []
            for data in coreData{
                array.append(convertToBasicEpisode(coreData: data))
            }
            return array
        }
        return nil
    }

    func convertToBasicEpisode(coreData: NSManagedObject) -> BasicEpisode {
        return BasicEpisode(id: coreData.value(forKey: "id") as? Int, comment: coreData.value(forKey: "comment") as? String)
    }
}
