//
//  ViewController.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    var kb: KeyboardContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kb = KeyboardContainer(frame: container.bounds)
        container.addSubview(kb!)
        kb!.pinEdgesTo(container)
    }
    
    @IBAction func isIt(_ sender: Any) {
        kb?.isStillExist()
    }
}

