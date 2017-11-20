//
//  StackGrid-Extensions.swift
//  StackGrid
//
//  Created by Jonas on 12/09/15.
//  Copyright © 2015 VFUC. All rights reserved.
//

import UIKit

extension UILayoutConstraintAxis {
    
    // Returns the (logical) opposite of an axis
    func inverse() -> UILayoutConstraintAxis {
        switch self {
        case .horizontal:
            return .vertical
            
        case .vertical:
            return .horizontal
        }
    }
}
