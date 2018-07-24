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
        //setting up change keyboard actions
       
        self.view.addSubview(self.keyboardContainer)
        keyboardContainer.pinEdgesTo(self.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.keyboardContainer.setupChangeKeyboardAction(owner: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func handleInputModeList(from view: UIView, with event: UIEvent) {
//        advanceToNextInputMode()
        super.handleInputModeList(from: view, with: event)
    }


}
