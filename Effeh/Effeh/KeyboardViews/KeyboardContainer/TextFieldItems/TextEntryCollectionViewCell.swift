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
            textField.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func setupCell(width: CGFloat, height: CGFloat){
//        translatesAutoresizingMaskIntoConstraints = false
        viewHeight.constant = height - 20
        viewWidth.constant = width
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func insertCharacter(_ char: String){
        textField.text?.append(char)
    }
    
    func deleteLastChar(){
        var text = textField.text
        guard text?.count != 0 else {
            return
        }
        text?.removeLast()
        textField.text = text
    }

}
