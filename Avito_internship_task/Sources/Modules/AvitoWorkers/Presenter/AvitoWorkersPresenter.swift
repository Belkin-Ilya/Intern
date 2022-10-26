//
//  AvitoWorkersPresenter.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 22.10.2022.
//

import UIKit

protocol AvitoWorkersPresenterProtocol {
    func getListViewModelCount() -> Int?
    func getListViewModelAt(index: Int) -> ListViewModel?
}

final class AvitoWorkersPresenter {
    
    // MARK: - Private Properties
    
    private weak var view: AvitoWorkersProtocol?
    private let repository: AvitoWorkersRepositoryProtocol?
    private var viewModels: [ListViewModel] = []
    
    // MARK: - Init
    
    init(view: AvitoWorkersProtocol, repository: AvitoWorkersRepositoryProtocol) {
        self.view = view
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    func viewLoaded() {
        view?.showActivityIndicator(isShow: true)
        repository?.fetchEmployees(completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.showActivityIndicator(isShow: false)
            }
            switch result {
            case .data(let data, let error):
                self?.viewModels = Mapper.makeSortedViewModels(workers: data)
                self?.view?.updateView()
                if let error = error {
                    self?.view?.presentError(error: error)
                }
            case .error(let error):
                self?.view?.presentError(error: error)
            }
        })
    }
}

// MARK: - AvitoWorkersPresenterProtocol

extension AvitoWorkersPresenter: AvitoWorkersPresenterProtocol {
    func getListViewModelCount() -> Int? {
        viewModels.count
    }
    
    func getListViewModelAt(index: Int) -> ListViewModel? {
        viewModels[index]
    }
}
