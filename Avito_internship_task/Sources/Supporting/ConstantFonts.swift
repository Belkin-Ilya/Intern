//
//  ConstantFonts.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 26.10.2022.
//

import Foundation

enum ConstantFonts {
    case avenirNext
    case avenirNextDemiBold
    
    func getValue() -> String {
        switch self {
        case .avenirNext:
            return NSLocalizedString("Avenir Next", comment: "")
        case .avenirNextDemiBold:
            return NSLocalizedString("Avenir Next Demi Bold", comment: "")
        }
    }
}

