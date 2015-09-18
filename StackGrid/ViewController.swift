//
//  ViewController.swift
//  StackGrid
//
//  Created by Jonas on 12/09/15.
//  Copyright © 2015 VFUC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var grid: StackGrid!
    
    var viewCount = 5
    let purple = UIColor(red:0.35, green:0.24, blue:0.76, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "addButton")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "-", style: .Plain, target: self, action: "removeButton")
        
        grid.setGridViews(createGradientViews(numOfViews: viewCount, color: purple))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func createGradientViews(numOfViews num: Int, color: UIColor) -> [UIView]{
        var views = [UIView]()
        
        let interval : Float = Float(1) / Float(num)
        for i in 0..<num{
            let view = UIView()
            view.backgroundColor = color.colorWithAlphaComponent(CGFloat(Float(i+1) * interval))
            views.append(view)
        }
        return views
    }
    
    
    func addButton(){
        grid.setGridViews(createGradientViews(numOfViews: ++viewCount, color: purple))
    }
    
    func removeButton(){
        grid.setGridViews(createGradientViews(numOfViews: --viewCount, color: purple))
    }
}