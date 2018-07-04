//
//  KeyboardView.swift
//  Effeh
//
//  Created by Michael Attia on 7/3/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    
    // Measurment variables
    private let keysPerRow: CGFloat = 11
    private let keyPadding: CGFloat = 5
    private lazy var keyWidth: CGFloat = {
        let totalSpace = UIScreen.main.bounds.width
        let paddingSpace = CGFloat(keysPerRow + 1) * keyPadding
        let availableSpace = totalSpace - paddingSpace
        return availableSpace / CGFloat(keysPerRow)
    }()
    lazy var keyHeight: CGFloat = keyWidth * 1.2
    
    private let layout = KeyboardLayout.arabicLayout
    
    func layoutKeys(){
        var currentYValue = keyPadding
        for row in layout.keyboardRows{
            var currentXValue = keyPadding
            for key in row{
                let keyButton: KeyboardkeyButton
                switch key.type{
                case .letter:
                    keyButton = KeyboardkeyButton(frame: CGRect(x: currentXValue,
                                                                y: currentYValue,
                                                                width: keyWidth,
                                                                height: keyHeight),
                                                  key: key)
                case .backspace:
                    let x = UIScreen.main.bounds.width - ((keyWidth * 1.5) + keyPadding)
                    keyButton = KeyboardkeyButton(frame: CGRect(x: x,
                                                                y: currentYValue,
                                                                width: keyWidth * 1.5,
                                                                height: keyHeight),
                                                  key: key)
                case .return:
                    let x = UIScreen.main.bounds.width - ((keyWidth * 3) + keyPadding)
                    keyButton = KeyboardkeyButton(frame: CGRect(x: x,
                                                                y: currentYValue,
                                                                width: keyWidth * 3,
                                                                height: keyHeight),
                                                  key: key)
                case .space:
                    let returnWidth = keyWidth * 3
                    let changeLangWidth = keyWidth * 2
                    let x = (keyPadding * 2) + changeLangWidth
                    let width = UIScreen.main.bounds.width - (returnWidth + changeLangWidth) - (keyPadding * 4)
                    keyButton = KeyboardkeyButton(frame: CGRect(x: x,
                                                                y: currentYValue,
                                                                width: width,
                                                                height: keyHeight),
                                                  key: key)
                case .changeKeyboard:
                    keyButton = KeyboardkeyButton(frame: CGRect(x: currentXValue,
                                                                y: currentYValue,
                                                                width: keyWidth * 2,
                                                                height: keyHeight),
                                                  key: key)
                }
                self.addSubview(keyButton)
                //FIXME: ADD target or delegate to key
                currentXValue = currentXValue + keyButton.frame.width + keyPadding
            }
            currentYValue = currentYValue + keyHeight + keyPadding
        }
    }
    
    func heightToFit() -> CGFloat{
        let rowsCount = layout.keyboardRows.count
        return (rowsCount * keyHeight) + ((rowsCount + 1) * keyPadding)
    }
}
