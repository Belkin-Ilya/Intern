//
//  Fonts.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 25.10.2022.
//

import UIKit

extension UIFont {
    
    // MARK: - Set font avenir next
    
    static func avenirNextSize20() -> UIFont? {
        return UIFont.init(name: ConstantFonts.avenirNext.getValue(), size: 20)
    }
    
    static func avenirNextSize14() -> UIFont? {
        return UIFont.init(name: ConstantFonts.avenirNext.getValue(), size: 14)
    }
    
    // MARK: - Set font avenir next demi bold
    
    static func avenirNextDemiBoldSize20() -> UIFont? {
        return UIFont.init(name: ConstantFonts.avenirNextDemiBold.getValue(), size: 20)
    }
    
    static func avenirNextDemiBoldSize10() -> UIFont? {
        return UIFont.init(name: ConstantFonts.avenirNextDemiBold.getValue(), size: 10)
    }
}
