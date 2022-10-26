//
//  ViewModels.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 22.10.2022.
//

import Foundation

struct ListViewModel {
    
    private let employee: Employee
    
    var name: String {
        employee.name
    }
    var phoneNumber: String {
        "Phone: \(employee.phoneNumber)"
    }
    var skills: String {
        "Skills: \(employee.skills.joined(separator: ", "))"
    }
    
    init(employee: Employee) {
        self.employee = employee
    }
}
