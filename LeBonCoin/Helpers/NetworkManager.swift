//
//  NetworkManager.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//

import Foundation

enum APIError {
    case noResponse, invalidUrl, noData
    static let kNetDomain = "Networking"
    var instance: Error {
        switch self {
        case .noResponse:
            return NSError(domain: APIError.kNetDomain, code: 9999, userInfo: nil)
        case .invalidUrl:
            return NSError(domain: APIError.kNetDomain, code: 9998, userInfo: nil)
        case .noData:
            return NSError(domain: APIError.kNetDomain, code: 9997, userInfo: nil)
        }
    }
}

enum APIName {
    case adsList, categoryList
    var endPoint: String {
        switch self {
        case .adsList:
            return Constants.baseUrl + "listing.json"
        case .categoryList:
            return Constants.baseUrl + "categories.json"
        }
    }
}

class NetworkManager {
    
    enum Method: String {
        case get
        case post
        case put
        var method: String { rawValue.uppercased() }
    }

    func request(fromURL url: URL, httpMethod: Method,  completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        let completeWithResult: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _error = error {
                completeWithResult(.failure(_error))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completeWithResult(.failure(APIError.noResponse.instance))
                return
            }
            if !(Int(urlResponse.statusCode/100) == 2) {
                completeWithResult(.failure(NSError(domain: APIError.kNetDomain, code: urlResponse.statusCode, userInfo: nil)))
                return
            }
            if let data = data {
                completeWithResult(.success(data))
            } else {
                completeWithResult(.failure(APIError.noData.instance))
            }
        }
        
        urlSession.resume()
    }
}
