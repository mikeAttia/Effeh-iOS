//
//  TextEntyCollectionViewCell.swift
//  Effeh
//
//  Created by Michael Attia on 6/27/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class TextEntryCollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.borderStyle = .none
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }

}
