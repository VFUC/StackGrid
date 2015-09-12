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





/*
//MARK: - Class
*/

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
    
    
    
    
    
    /*
    //MARK: Methods
    */
    
    override func drawRect(rect: CGRect) {
        self.addSubview(rootNode)
        pinToEdges(rootNode)
    }
    
    
    func setGridViews(views: [UIView]) {
        let testView = UIView()
        testView.backgroundColor = UIColor.purpleColor()
        
        let testView2 = UIView()
        testView2.backgroundColor = UIColor.redColor()
        
        rootNode.addArrangedSubview(testView)
        rootNode.addArrangedSubview(testView2)
    }
    
    
    func pinToEdges(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1,
            constant: 0))
        
        self.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Right,
            multiplier: 1,
            constant: 0))
        
        self.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: 0))
        
        self.addConstraint(NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0))
    }
    
}