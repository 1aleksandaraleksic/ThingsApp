//
//  ServiceManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 7.6.23..
//

import Foundation
import Alamofire

enum RequestError: Int {
    case urlNotValid = 1
    case parsingFailed = 2
    case badRequest = 400
    case unathorized = 401
    case forbidden = 403
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case timeout = 504
    case unknown = 999
}

class ServiceManager {

    public static let shared = ServiceManager()

    func invoke<T: Decodable>(url: String,
                              method: HTTPMethod = .get,
                              model: T.Type = T.self,
                              headers: HTTPHeaders = [],
                              success: @escaping ((T) -> Void),
                              fail: @escaping ((RequestError) -> Void)) {

        guard let url = URL(string: url.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            fail(.urlNotValid)
            return
        }

        var mergedHeaders = headers
        mergedHeaders.add(HTTPHeader(name: "Content-Type", value: "application/json"))

        let request = AF.request(url, method: method, headers: mergedHeaders) { urlRequest in
            //MARK: Expand if necessary to send json body in request. Convert parameters to json.
        }

        request.responseDecodable(of: T.self) { (response) in

            switch response.result {
            case .success:
                guard let value = response.value else {
                    fail(.parsingFailed)
                    return
                }
                success(value)

                break
            case .failure(let error):
                if let code = error.responseCode,
                let reason = RequestError(rawValue: code) {
                    fail(reason)
                } else {
                    fail(.unknown)
                }
            }

        }

    }
}
