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
    var store = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.getKeywordsContaining("sam")
    }
    
    @IBAction func isIt(_ sender: Any) {
    }
}

