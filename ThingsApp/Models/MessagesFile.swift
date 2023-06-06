//
//  MessagesFile.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import Foundation

public struct MessagesFile: Decodable {
    var version: String?
    var home: HomeMessages?
}

struct HomeMessages: Decodable {
    var title, subtitle, buttonTitle: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, subtitle
        case buttonTitle = "btn_title"
    }
}
