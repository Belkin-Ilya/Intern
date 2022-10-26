//
//  Mapper.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 24.10.2022.
//

import Foundation

final class Mapper {
    static func makeSortedViewModels(workers: CompanyWorkers) -> [ListViewModel] {
        return workers.company.employees.map { ListViewModel(employee: $0) }.sorted(by: { $0.name < $1.name })
    }
}
