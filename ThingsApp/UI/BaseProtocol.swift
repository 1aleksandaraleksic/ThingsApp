//
//  BaseProtocol.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import Foundation

protocol BaseProtocol{
    var parameters: [Any]? {get set}
    func setupUI()
}
