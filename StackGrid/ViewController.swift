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
    
    var initialViewCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "addButton")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "-", style: .Plain, target: self, action: "removeButton")
        
        grid.setGridViews(createGradientViews(numOfViews: initialViewCount))
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
    
    
    func addButton(){
        grid.addGridView(UIView.randomDefaultColorView())
    }
    
    func removeButton(){
        grid.removeLastGridView()
    }
}


extension UIColor{
    
    class func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(150)) / 255
        let green = CGFloat(arc4random_uniform(150)) / 255
        let blue = CGFloat(arc4random_uniform(150)) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func randomDefaultColor() -> UIColor{
        let defaultColors:[UIColor] = [
            UIColor.redColor(),
            UIColor.orangeColor(),
            UIColor.yellowColor(),
            UIColor.greenColor(),
            UIColor.blueColor(),
            UIColor.brownColor(),
            UIColor.magentaColor(),
            UIColor.purpleColor()
        ]
        
        let randomIndex = Int(arc4random_uniform(UInt32(defaultColors.count)))
        return defaultColors[randomIndex]
    }
}

extension UIView{
    class func randomColorView()->UIView{
        let view = UIView()
        view.backgroundColor = UIColor.randomColor()
        return view
    }
    
    class func randomDefaultColorView()->UIView{
        let view = UIView()
        view.backgroundColor = UIColor.randomDefaultColor()
        return view
    }
}