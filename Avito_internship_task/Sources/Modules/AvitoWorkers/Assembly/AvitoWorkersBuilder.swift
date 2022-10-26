//
//  AvitoWorkersBuilder.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 22.10.2022.
//

import UIKit

final class AvitoWorkersBuilder: ModuleBuilder {
    static func createModule() -> UIViewController {
        let viewController = AvitoWorkersViewController()
        let cacheStorage = CacheStorage()
        let repository = AvitoWorkersRepository(cacheStorage: cacheStorage)
        let presenter = AvitoWorkersPresenter(view: viewController, repository: repository)
        
        viewController.presenter = presenter
        return viewController
    }
}
