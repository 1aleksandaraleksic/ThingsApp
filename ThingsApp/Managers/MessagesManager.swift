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
        guard let localMessagesUrl = Bundle.main.url(forResource: "messages", withExtension: ".json")?.absoluteString else { return }

        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask).first

        if let localUrl = URL(string: localMessagesUrl),
           let dataFile = try? Data(contentsOf: localUrl),
           let stringFile = String(data: dataFile, encoding: .utf8) {
            do {
                if let filePath = path?.appendingPathComponent("messages.json") {

                    if(!FileManager.default.fileExists(atPath: filePath.path)) {
                        try stringFile.write(to: filePath, atomically: true, encoding: .utf8)
                    }
                }
            } catch {
                print("Error writing data: \(error.localizedDescription)")
            }
        }
    }
}
