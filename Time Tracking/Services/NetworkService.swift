//
//  NetworkService.swift
//  Time Tracking
//
//  Created by Marlon Morato on 27/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation
import Moya


typealias DecodableResultCompletionHandler<T:Decodable> = (Result<T,Error>) -> Void

protocol NetworkServiceContract {
    func get<T: Decodable,E:TargetType>(targetType: E, type: T.Type, completionHandler: @escaping DecodableResultCompletionHandler<T>)
}

class NetworkService: NetworkServiceContract {
    func get<T: Decodable,E:TargetType>(targetType: E, type: T.Type, completionHandler: @escaping DecodableResultCompletionHandler<T>) {
        let session = URLSession.shared
        guard let url = targetType.simpleUrl else {
            completionHandler(Result.failure(NSError(domain: "url inv;alida", code: 0, userInfo: nil)))
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                completionHandler(Result.failure(error ?? NSError(domain: "error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completionHandler(Result.success(result))
            } catch {
                completionHandler(Result.failure(error))
            }
        }.resume()
    }
}

class MoyaNetworkService: NetworkServiceContract {
    func get<T,E:TargetType>(targetType: E, type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        // TODO: IMPLEMENTAR UTILIZANDO O MOYA: https://github.com/Moya/Moya
        let provider = MoyaProvider<E>()
        provider.request(targetType) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let decodable = try moyaResponse.map(type)
                    completionHandler(Result.success(decodable))
                    return
                }
                catch {
                    completionHandler(Result.failure(error))
                    return
                }
            case let .failure(error):
                completionHandler(Result.failure(error))
                return
            }
        }
    }
}

extension TargetType {
    var simpleUrl: URL? {
        switch self.task {
        case .requestParameters(let parameters, _):
            guard let url = URL(string: self.path, relativeTo: self.baseURL) else {
                return nil
            }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters.map({ (keyValue) -> URLQueryItem in
                return URLQueryItem(name: keyValue.key, value: "\(keyValue.value)")
            })
            
            return try? components?.asURL()
        default:
            return URL(string: self.path, relativeTo: self.baseURL)
        }
        
    }
}
