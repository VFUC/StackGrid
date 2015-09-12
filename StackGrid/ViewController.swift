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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid.setGridViews(createGradientViews(numOfViews: 5))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func createGradientViews(numOfViews num: Int) -> [UIView]{
        var views = [UIView]()
        
        let color = UIColor(red:0.35, green:0.24, blue:0.76, alpha:1)
        let interval : Float = Float(1) / Float(num)
        
        for i in 0..<num{
            let view = UIView()
            view.backgroundColor = color.colorWithAlphaComponent(CGFloat(Float(i+1) * interval))
            view.tag = i
            views.append(view)
        }
        
        return views
    }
}

