//
//  SampleUserService.swift
//  Time Tracking
//
//  Created by Marlon Morato on 27/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation

typealias SampleUsersResultHandler = (Result<[SampleUser],Error>) -> Void

protocol SampleUserServiceContract {
    func getSampleUsers(completionHandler: @escaping SampleUsersResultHandler)
}

class SampleUserService: SampleUserServiceContract {
    let networkService: NetworkServiceContract
    
    init(networkService: NetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getSampleUsers(completionHandler: @escaping SampleUsersResultHandler) {
        networkService.get(targetType: MyService.showPeople, type: [SampleUser].self) { (result) in
            switch result {
            case .success(let users): completionHandler(Result.success(users))
            case .failure(let error): completionHandler(Result.failure(error))
            }
        }
    }
}

