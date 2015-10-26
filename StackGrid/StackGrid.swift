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
    
    private let rootNode: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        }()
    
    private var tree = [TreeElement]()
    private var views = [UIView]()
    private var viewsToDisplay = [UIView]() {
        didSet {
            if viewsToDisplay.count >= 0 {
                buildTreeForNodeCount(viewsToDisplay.count)
                updateViews()
            }
        }
    }
    
    
    
    
    /*
    //MARK: Methods
    */
    
    override func drawRect(rect: CGRect) {
        self.addSubview(rootNode)
        pinToEdges(rootNode)
    }
	
	
	/**
	Set orientation of the root node's axis
	- parameter axis The axis to apply to the root node
	*/
	func setRootAxis(axis: UILayoutConstraintAxis){
		rootNode.axis = axis
		if viewsToDisplay.count >= 0 {
			buildTreeForNodeCount(viewsToDisplay.count)
			updateViews()
		}
	}
	
    /**
    Set views to be displayed in grid.
    This overwrites all current views.
    - parameter views The views to be displayed
    */
    func setGridViews(views: [UIView]) {
        viewsToDisplay = views
    }
    
    /**
    Add view to grid.
    This appends a view to the end of the current views
    - parameter view The view to be added
    */
    func addGridView(view: UIView){
        viewsToDisplay.append(view)
    }
    
    /**
    Add views to grid
    This appends multiple views to the end of the current views
    - parameter views The views to be added
    */
    func addGridViews(views: [UIView]) {
        for view in views {
            addGridView(view)
        }
    }
    
    /**
    Remove view from grid
    - index Specify which view should be removed
    */
    func removeGridViewAtIndex(index: Int) {
        guard index >= 0 && index<viewsToDisplay.count else {
            print("Error: removeGridViewAtIndex called with index out of bounds, aborting")
            return
        }
        viewsToDisplay.removeAtIndex(index)
    }
    
    
    /**
    Removes last view from grid
    */
    func removeLastGridView() {
        guard viewsToDisplay.count > 0 else {
            print("Error: removeLastGridView called on empty grid")
            return
        }
        viewsToDisplay.removeLast()
    }
    
    
    
    
    private func pinToEdges(view: UIView) {
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
    
    
    
    /*
    //MARK: Layout Construction
    */
    
    private func buildTreeForNodeCount(count: Int) {
        
        guard count >= 0 else {
            print("ERROR - Can't build tree for node count <= 0")
            return
        }
        
        //reset tree
        tree = [TreeElement]()
        
        if count == 0 { //return with empty tree
            return
        }
        
        
        // add nodes to tree
        for _ in 0..<count {
            let node = TreeElement(type: .Node)
            tree.append(node)
        }
        
        // add leaves to tree
        for _ in 0..<count {
            let leaf = TreeElement(type: .Leaf)
            tree.append(leaf)
        }
        
        
        
        //attach nodes
        //iterate over all nodes except for root node (is not attached to any node)
        for i in 1..<tree.count where tree[i].type == .Node {
            
            //look for a node to attach to
            for j in tree.indices where tree[i].type == .Node && i != j{
                
                //if inspected node has no child index yet, attach and stop looking
                if tree[j].child1ViewIndex == nil {
                    tree[j].child1ViewIndex = i
                    tree[i].set = true
                    break
                }
                
                if tree[j].child2ViewIndex == nil{
                    tree[j].child2ViewIndex = i
                    tree[i].set = true
                    break
                }
            }
            
            guard tree[i].set else {
                print("ERROR - Couldn't attach node with index \(i) to other nodes")
                return
            }
        }
        
        
        //attach leaves
        let firstLeafLayer = getLayerForIndex(count) //count = first leaf
        let secondLeafLayer = allLeavesSameLayer() ? firstLeafLayer : firstLeafLayer + 1 //if all leaves same layer then both layers are same
        
        let firstNodeLayer = firstLeafLayer - 1
        let secondNodeLayer = secondLeafLayer - 1
        
        
        //Fill up first leaf Layer backwards
        //iterate over all leaves, backwards
        if firstLeafLayer != secondLeafLayer {//only if layers are different, else skip right to forwards fill up!
            
            for i in tree.indices.reverse() where tree[i].type == .Leaf{
                
                //iterate over nodes on the correct layer, backwards
                for j in tree.indices.reverse() where (tree[j].type == .Node) && (getLayerForIndex(j) == firstNodeLayer) {
                    
                    //attach if no child yet, do child2 first because we're filling up backwards
                    if tree[j].child2ViewIndex == nil{
                        tree[j].child2ViewIndex = i
                        tree[i].set = true
                        break
                    }
                    
                    if tree[j].child1ViewIndex == nil {
                        tree[j].child1ViewIndex = i
                        tree[i].set = true
                        break
                    }
                }
            }
            
        }
        
        //Fill up second leaf layer forwards
        //iterate over leaves which have not been set yet, forward
        for i in 0..<tree.count where (tree[i].type == .Leaf) && !tree[i].set {
            
            for j in tree.indices where (tree[j].type == .Node) && (getLayerForIndex(j) == secondNodeLayer) {
                
                //attach if no child yet
                if tree[j].child1ViewIndex == nil {
                    tree[j].child1ViewIndex = i
                    tree[i].set = true
                    break
                }
                
                if tree[j].child2ViewIndex == nil{
                    tree[j].child2ViewIndex = i
                    tree[i].set = true
                    break
                }
            }
        }
        
        //All nodes/leaves should now be attached
        for i in 1..<tree.count {
            guard tree[i].set else {
                print("ERROR - All tree elements should be set now, but element with index \(i) has not")
                return
            }
        }
    }
    
    private func updateViews() {
        
        if viewsToDisplay.count == 0 {
            for view in views where !view.isKindOfClass(UIStackView) { //remove all leaves from superviews
                view.removeFromSuperview()
            }
            
            //overwrite views
            views = [rootNode]
            
            return
        }
        
        
        while getNodeCount() > getNodeViewCount() { //nodes have been added to tree
            views.insert(getNewNodeView(), atIndex: getEndOfNodeViewsIndex()) //add node view to end
        }
        
        while getNodeViewCount() > getNodeCount() { //nodes have been removed from tree
            views.removeAtIndex(getEndOfNodeViewsIndex() - 1) //remove node view from end
        }
        
        if views[0] != rootNode { //make sure root node is in place
            views[0] = rootNode
        }
        
        
        for i in 0..<getEndOfNodeViewsIndex() {
            guard views[i].isKindOfClass(UIStackView) else{
                print("ERROR: View with index \(i) should be a node/stack view")
                break
            }
            
            let nodeView = views[i] as! UIStackView
            if getLayerForIndex(i) % 2 == 0 {
                nodeView.axis = rootNode.axis
            } else {
                nodeView.axis = rootNode.axis.inverse()
            }
        }
        
        
        //add leaves
        
        while getLeafViewCount() > getLeafCount() {
            views.removeLast()
        }
        
        for i in viewsToDisplay.indices {
            let nodeViewCount = getNodeViewCount()
            
            if (nodeViewCount + i ) > views.count - 1 { //check if view at that index exists already, if not nodeViewCount + i would be > views.count - 1 and therefore out of bounds
                views.insert(viewsToDisplay[i], atIndex: nodeViewCount + i) //if not append
            } else {
                if views[nodeViewCount + i] != viewsToDisplay[i] { //overwrite if different
                    views[nodeViewCount + i] = viewsToDisplay[i]
                }
            }
        }
        
        
        //views are now in place, need to be attached to each other
        
        for i in tree.indices where tree[i].type == .Node{
            guard views[i].isKindOfClass(UIStackView) else {
                print("ERROR - View with index \(i) should be a Node/StackView!")
                return
            }
            
            let nodeView = views[i] as! UIStackView
            
            var childViews = [UIView]()
            
            if let child1 = tree[i].child1ViewIndex {
                childViews.append(views[child1])
            }
            
            if let child2 = tree[i].child2ViewIndex {
                childViews.append(views[child2])
            }
            
            //if subview is not supposed to be subview, remove
            for subView in nodeView.arrangedSubviews {
                if !childViews.contains(subView) {
                    subView.removeFromSuperview()
                }
            }
            
            //if childview is supposed to be attached, attach
            for childView in childViews {
                if !nodeView.arrangedSubviews.contains(childView) {
                    childView.removeFromSuperview() //remove in case it is still attached to another stackview
                    nodeView.addArrangedSubview(childView)
                }
            }
			
			guard childViews.count == nodeView.arrangedSubviews.count else {
				print("ERROR: ChildViews should contain same number of elements as arrangedSubviews")
				return
			}
			
			guard childViews.count <= 2 else {
				print("ERROR: Node should not have more than 2 child views!")
				return
			}
			
			//check order of childViews
			if childViews.count == 2 { //doesn't make sense with 1 view
				let childView = childViews[0]
				let subViewIndex = nodeView.arrangedSubviews.indexOf(childView) //if the two indices are equal, the views are in order
				
				if subViewIndex != 0 { //not in order => swap
					let view0 = nodeView.arrangedSubviews[0]
					nodeView.removeArrangedSubview(view0) //swap by removing and appending
					nodeView.addArrangedSubview(view0)
				}
			}
			
		}
    }
    
    
    
    private func getLayerForIndex(index: Int) -> Int{
        var layer = 0
        var i = 0
        
        while i < index{
            i += Int(2 * pow(Double(2),Double(layer)))
            
            layer++
        }
        
        return layer
    }
    
    
    //determines whether all leaves are same layer
    private func allLeavesSameLayer() -> Bool {
        var set = false
        var layer = -1
        
        for i in tree.indices where tree[i].type == .Leaf {
            if !set {
                layer = getLayerForIndex(i)
                set = true
            }else{
                if getLayerForIndex(i) != layer {
                    return false
                }
            }
        }
        
        return true
    }
    
    
    private func getNodeCount() -> Int {
        var count = 0
        for element in tree where element.type == .Node {
            count++
        }
        return count
    }
    
    private func getLeafCount() -> Int {
        var count = 0
        for element in tree where element.type == .Leaf {
            count++
        }
        return count
    }
    
    
    private func getNodeViewCount() -> Int {
        var count = 0
        for view in views where view.isKindOfClass(UIStackView) {
            count++
        }
        return count
    }
    
    private func getLeafViewCount() -> Int {
        var count = 0
        for view in views where !view.isKindOfClass(UIStackView) {
            count++
        }
        return count
    }
    
    //returns index of first non-node view in views
    private func getEndOfNodeViewsIndex() -> Int {
        for i in views.indices {
            if !views[i].isKindOfClass(UIStackView) {
                return i
            }
        }
        
        return views.count //if no leaves => end of array is end of views
    }
    
    private func getNewNodeView() -> UIStackView {
        let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .FillEqually
        return stackView
    }
    
    
    
    /*
    //MARK: Debug Helpers
    */
    
    private func printTree(){
        for i in tree.indices {
            
            print("\(getIDStringForIndex(i)), index: \(i), type: \(tree[i].type)")
            
            if let child1 = tree[i].child1ViewIndex {
                print(" Child 1: \(getIDStringForIndex(child1)), index: \(child1)")
            }
            
            if let child2 = tree[i].child2ViewIndex {
                print(" Child 2: \(getIDStringForIndex(child2)), index: \(child2)")
            }
        }
    }
    
    private func getIDStringForIndex(index: Int) -> String {
        
        switch tree[index].type {
        case .Leaf:
            return "v\(index - (tree.count / 2))"
        case .Node:
            return "s\(index)"
        }
    }
    
    
    
    private func printStackViewStructure(views: [UIView]){
        print("--")
        for i in views.indices{
            if views[i].isKindOfClass(UIStackView){
                let subContainer = (views[i] as! UIStackView)
                print("\(i) - UIStackView - \(subContainer.hashValue)")
                printStackViewStructureWithPrefix("-", views: subContainer.arrangedSubviews)
            }else{
                print("\(i) - UIView - \(views[i].hashValue) - \(views[i].backgroundColor?.description) - tag: \(views[i].tag)")
            }
        }
        print("\n")
    }
    
    private func printStackViewStructureWithPrefix(prefix: String, views: [UIView]){
        for view in views{
            if view.isKindOfClass(UIStackView){
                let subContainer = (view as! UIStackView)
                print(prefix + "UIStackView - \(subContainer.hashValue)")
                printStackViewStructureWithPrefix(prefix + "-", views: subContainer.arrangedSubviews)
            }else{
                print(prefix + "UIView - \(view.hashValue) - tag: \(view.tag)")
            }
        }
    }
    
    
    
}