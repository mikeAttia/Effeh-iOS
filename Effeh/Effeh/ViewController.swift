//
//  ViewController.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var icon: TabItem!
    
    @IBAction func changeColor(_ sender: Any) {
        icon.isSelected = !icon.isSelected
    }

    @IBOutlet weak var testView: UIView!{
        didSet{
            testView.layer.cornerRadius = testView.frame.height / 2
        }
    }
    
}

