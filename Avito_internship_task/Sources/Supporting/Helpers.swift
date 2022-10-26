//
//  Helpers.swift
//  Avito_internship_task
//
//  Created by Илья Белкин on 26.10.2022.
//

import UIKit

protocol AutoLayoutAble { }

extension AutoLayoutAble where Self: UIView {
    var forAutolayout: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIView: AutoLayoutAble {}

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment) {
        self.init()
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
}

