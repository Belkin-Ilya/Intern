//
//  AvitoWorkersViewController.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 21.10.2022.
//

import UIKit

protocol AvitoWorkersProtocol: AnyObject {
    func updateView()
    func presentError(error: ErrorViewable)
    func showActivityIndicator(isShow: Bool)
}

final class AvitoWorkersViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: AvitoWorkersPresenter?
    private let titleString = ConstantStrings.navigationTitle
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = AvitoWorkersView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = titleString
        presenter?.viewLoaded()
    }
}

// MARK: - AvitoWorkersProtocol

extension AvitoWorkersViewController: AvitoWorkersProtocol {
    func showActivityIndicator(isShow: Bool) {
        guard let view = self.view as? AvitoWorkersView else {
            return
        }
        view.showActivityIndicator(isShow: isShow)
    }
    
    func updateView() {
            DispatchQueue.main.async { [weak self] in
                guard let view = self?.view as? AvitoWorkersView else {
                    return
                }
                view.workersListTableView.reloadData()
            }
        }
    
    func presentError(error: ErrorViewable) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            let action = UIAlertAction(title: ConstantStrings.alertErrorTitle, style: .cancel)
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - AvitoWorkersViewDelegate

extension AvitoWorkersViewController: AvitoWorkersViewDelegate {
    func avitoWorkersViewNumbeOfRowsInSection(_ avitoWorkersView: AvitoWorkersView) -> Int? {
        presenter?.getListViewModelCount()
    }
    
    func avitoWorkersViewCellForRowAt(_ avitoWorkersView: AvitoWorkersView, getDataAtIndex index: Int) -> ListViewModel? {
        presenter?.getListViewModelAt(index: index)
    }
    
    
}
