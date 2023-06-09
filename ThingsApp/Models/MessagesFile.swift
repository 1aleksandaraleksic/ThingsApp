//
//  MessagesFile.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import Foundation

public struct MessagesFile: Codable {
    var version: String?
    var home: HomeMessages?
    var detail: Detail?
}

struct HomeMessages: Codable {
    var title, subtitle, buttonTitle: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, subtitle
        case buttonTitle = "btn_title"
    }
}

struct Detail: Codable {
    var selectedDetailTitle: String?
    var buttonTitle: String?

    private enum CodingKeys: String, CodingKey {
        case selectedDetailTitle = "selected_detail_title"
        case buttonTitle = "btn_title"
    }
}
