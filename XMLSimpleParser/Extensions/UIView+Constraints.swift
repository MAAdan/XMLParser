//
//  UIView+Constraints.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 31/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

enum ConstraintsError: Error {
    case moreThanOneConstraintFound
}


extension UIView {
    func getConstraintWith(id: String) throws -> NSLayoutConstraint? {
        let foundConstraints = constraints.filter{ $0.identifier == id}
        guard let constraint = foundConstraints.first, foundConstraints.count == 1 else {
            throw ConstraintsError.moreThanOneConstraintFound
        }
        
        return constraint
    }
}
