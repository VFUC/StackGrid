//
//  StackGrid-Extensions.swift
//  StackGrid
//
//  Created by Jonas on 12/09/15.
//  Copyright © 2015 VFUC. All rights reserved.
//

import UIKit

extension NSLayoutConstraint.Axis {
    
    // Returns the (logical) opposite of an axis
    func inverse() -> NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return .vertical
            
        case .vertical:
            return .horizontal
        }
    }
}
