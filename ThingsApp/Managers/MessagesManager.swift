//
//  MessagesManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import Foundation

public var messages = MessagesManager.shared.messagesFile

class MessagesManager {

    static let shared = MessagesManager()
    fileprivate var messagesFile: MessagesFile?

    private init(){
        loadMessages()
    }

    private func loadMessages(){
        let path = Bundle.main.path(forResource: "messages", ofType: "json") ?? ""

        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let jsonData = try JSONDecoder().decode(MessagesFile.self, from: data)
            self.messagesFile = jsonData
        } catch {
            print("ERROR: fetching local json")
        }

    }
}
