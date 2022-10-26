//
//  NetworkService.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 21.10.2022.
//

import UIKit

enum NetworkError: Error, ErrorViewable {
    case invalidURL
    case noData
    case decodingError
    case noConnection
    case unknown
    
    var title: String {
        return "Oops, an error..."
    }
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid link"
        case .noData:
            return "No data available"
        case .decodingError:
            return "Invalid data format"
        case .noConnection:
            return "There is no internet connection"
        case .unknown:
            return "Unknown error"
        }
    }
}

final class NetworkService {
    // MARK: - Public Properties
    
    static let shared = NetworkService()
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private enum Path {
        static let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    }
    
    // MARK: - Public Methods
    
    func fetchData<T: Codable>(of type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: Path.urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case -1009:
                    completion(.failure(.noConnection))
                default:
                    completion(.failure(.unknown))
                }
                return
            }
            guard let parseredData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: parseredData)
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
