//
//  AvitoWorkersTableView.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 25.10.2022.
//

import UIKit

protocol AvitoWorkersTableViewDelegate: AnyObject {
    func avitoWorkersTableViewNumbeOfRowsInSection(_ avitoWorkersTableView: AvitoWorkersTableView) -> Int?
    func avitoWorkersTableViewCellForRowAt(_ avitoWorkersTableView: AvitoWorkersTableView, cellForRowAt index: Int) -> ListViewModel?
}

final class AvitoWorkersTableView: UITableView {
    
    // MARK: - Public Properties
    
    weak var customDelegate: AvitoWorkersTableViewDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        register(AvitoWorkersTableViewCell.self, forCellReuseIdentifier: AvitoWorkersTableViewCell.identifier)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension AvitoWorkersTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customDelegate?.avitoWorkersTableViewNumbeOfRowsInSection(self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AvitoWorkersTableViewCell.identifier, for: indexPath) as? AvitoWorkersTableViewCell,
              let viewModel = customDelegate?.avitoWorkersTableViewCellForRowAt(self, cellForRowAt: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.configure(model: viewModel)
        return cell
    }
}
