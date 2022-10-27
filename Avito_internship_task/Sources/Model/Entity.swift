//
//  Entity.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 21.10.2022.
//

import Foundation

// MARK: - CompanyWorkers
struct CompanyWorkers: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
