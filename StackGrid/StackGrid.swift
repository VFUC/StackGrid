//
//  StackGrid.swift
//  StackGrid
//
//  Created by Jonas on 12/09/15.
//  Copyright © 2015 VFUC. All rights reserved.
//

import UIKit


/*
//MARK: Types
*/

struct TreeElement {
    var type: TreeElementType
    var child1ViewIndex, child2ViewIndex : Int?
    var set = false
    
    init(type: TreeElementType){
        self.type = type
    }
    
}

enum TreeElementType{
    case Node
    case Leaf
}







class StackGrid : UIView {
    
    /*
    //MARK: Properties
    */
    
    let rootNode: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        return stackView
        }()
    
    var tree = [TreeElement]()
    var views = [UIView]()
    
    
}