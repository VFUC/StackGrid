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
        
        grid.setGridViews([UIView]())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

