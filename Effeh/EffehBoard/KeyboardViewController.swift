//
//  KeyboardViewController.swift
//  EffehBoard
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    private var keyboardContainer: KeyboardContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.keyboardContainer = KeyboardContainer(frame: self.view.bounds)
        self.keyboardContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.keyboardContainer)
        keyboardContainer.pinEdgesTo(self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }


}
