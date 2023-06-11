//
//  Episode.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 12.6.23..
//

import CoreData

class EpisodeCore: NSManagedObject {

    @NSManaged var comment: String?
    @NSManaged var id: Int64
}
