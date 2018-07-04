//
//  ViewController.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var v: KeyboardContainer?
    
    override func viewDidLoad() {
        v = KeyboardContainer(frame: self.view!.frame)
        self.view.addSubview(v!)
    }
}

