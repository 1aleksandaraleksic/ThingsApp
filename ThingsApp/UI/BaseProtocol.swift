//
//  BaseProtocol.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 5.6.23..
//

import Foundation

protocol BaseProtocol{
    var parameters: [Constants.ParametersVariabile: Any]? {get}
    func setupUI(_ parameters: [Constants.ParametersVariabile: Any]?)
}
