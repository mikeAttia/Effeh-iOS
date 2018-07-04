//
//  KeyboardkeyButton.swift
//  Effeh
//
//  Created by Michael Attia on 7/3/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardkeyButton: UIButton {

    var defaultBackgroundColor: UIColor = .white
    var highlightBackgroundColor: UIColor = .lightGray
    var key: KeyboardKey!
    
    convenience init(frame: CGRect, key: KeyboardKey) {
        self.init(frame: frame)
        self.key = key
        switch key.type {
        case .letter, .return, .space:
            self.setTitle(key.char, for: .normal)
        case .backspace:
            self.setImage(#imageLiteral(resourceName: "arabicBackSpace"), for: .normal)
        case .changeKeyboard:
            self.setImage(#imageLiteral(resourceName: "globe"), for: .normal)
        }
        self.setTitleColor(.black, for: .normal)
        self.tintColor = .black
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Initiating \(String(describing: KeyboardkeyButton.self))in storyboards on Xib files isn't supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
    }
    private func initView() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.35
        self.imageView?.contentMode = .scaleAspectFit
    }

}
