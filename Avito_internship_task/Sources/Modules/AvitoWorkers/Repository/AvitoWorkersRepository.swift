//
//  AvitoWorkersRepository.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 22.10.2022.
//

import Foundation

protocol ErrorViewable {
    var message: String { get }
    var title: String { get }
}

protocol AvitoWorkersRepositoryProtocol {
    func fetchEmployees(completion: @escaping (Response) -> Void)
}

enum Response {
    case data(data: CompanyWorkers, error: ErrorViewable?)
    case error(ErrorViewable)
}

final class AvitoWorkersRepository: AvitoWorkersRepositoryProtocol {
    
    let network = NetworkService.shared
    let cacheStorage: CacheStorageProtocol
    
    // MARK: - Init
    
    init(cacheStorage: CacheStorageProtocol) {
        self.cacheStorage = cacheStorage
    }
    
    // MARK: - Public Methods
    
    func fetchEmployees(completion: @escaping (Response) -> Void) {
        network.fetchData(of: CompanyWorkers.self) { [weak self] result in
            switch result {
            case .success(let workers):
                print("Successfully got data from server")
                self?.cacheStorage.setCacheCopy(workers: workers)
                completion(.data(data: workers, error: nil))
            case .failure(let error):
                print("Network error, trying to access cache")
                self?.cacheStorage.getCacheCopy(completion: { result in
                    switch result {
                    case .success(let workers):
                        completion(.data(data: workers, error: error))
                    case .failure(let error):
                        completion(.error(error))
                    }
                })
            }
        }
    }
}

