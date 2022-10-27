//
//  AvitoWorkersView.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 25.10.2022.
//

import UIKit

protocol AvitoWorkersViewDelegate: AnyObject {
    func avitoWorkersViewNumbeOfRowsInSection(_ avitoWorkersView: AvitoWorkersView) -> Int?
    func avitoWorkersViewCellForRowAt(_ avitoWorkersView: AvitoWorkersView, getDataAtIndex index: Int) -> ListViewModel?
}

final class AvitoWorkersView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: AvitoWorkersViewDelegate?
    
    lazy var workersListTableView: AvitoWorkersTableView = {
        let tableView = AvitoWorkersTableView().forAutolayout
        tableView.showsVerticalScrollIndicator = false
        tableView.customDelegate = self
        return tableView
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView().forAutolayout
        return loader
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setWorkersListTableViewConstraints()
        setLoaderConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public Methods
    
    func showActivityIndicator(isShow: Bool) {
        if isShow {
            self.loader.startAnimating()
        } else {
            self.loader.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [workersListTableView, loader].forEach { subView in addSubview(subView) }
    }
    
    private func setWorkersListTableViewConstraints() {
        NSLayoutConstraint.activate([
            workersListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            workersListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            workersListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            workersListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setLoaderConstraints() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - AvitoWorkersTableViewDelegate

extension AvitoWorkersView: AvitoWorkersTableViewDelegate  {
    func avitoWorkersTableViewNumbeOfRowsInSection(_ avitoWorkersTableView: AvitoWorkersTableView) -> Int? {
        delegate?.avitoWorkersViewNumbeOfRowsInSection(self) ?? 0
    }
    
    func avitoWorkersTableViewCellForRowAt(_ avitoWorkersTableView: AvitoWorkersTableView, cellForRowAt index: Int) -> ListViewModel? {
        delegate?.avitoWorkersViewCellForRowAt(self, getDataAtIndex: index)
    }
}
