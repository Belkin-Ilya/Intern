//
//  CacheStorage.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 26.10.2022.
//

import Foundation

enum LocalError: Error {
    case empty
    case expired
}

private enum UserDefaultsKeys {
    static let timeTrackerKey = "timeTracker"
    static let cacheEmployeeKey = "cacheEmployee"
}

protocol CacheStorageProtocol {
    func getCacheCopy(completion: @escaping (Result<CompanyWorkers, LocalError>) -> Void)
    func setCacheCopy(workers: CompanyWorkers)
}

final class CacheStorage: CacheStorageProtocol {
    
    private let experesionPeriod: Double = 3600

    @UserDefault(UserDefaultsKeys.timeTrackerKey, defaultValue: Date())
    
    private var timeTracker: Date
    
    @UserDefault(UserDefaultsKeys.cacheEmployeeKey, defaultValue: nil, encodeAsJSON: true)
    
    private var cacheWorkers: CompanyWorkers?
    
    func setCacheCopy(workers: CompanyWorkers) {
        cacheWorkers = workers
        timeTracker = Date()
    }
    
    func getCacheCopy(completion: @escaping (Result<CompanyWorkers, LocalError>) -> Void) {
        if Date().timeIntervalSince(timeTracker) > experesionPeriod {
            completion(.failure(.expired))
            print(ConstantStrings.unsuccessfullGetDataFromCache)
        } else {
            if let cacheWorkers = cacheWorkers {
                completion(.success(cacheWorkers))
                print(ConstantStrings.findDataInCache)
            } else {
                completion(.failure(.empty))
                print(ConstantStrings.noDataTitle)
            }
        }
    }
}

extension LocalError: ErrorViewable {
    var message: String { ConstantStrings.localErrorMessageCache }
    var title: String { ConstantStrings.localErrorTitle }
}
