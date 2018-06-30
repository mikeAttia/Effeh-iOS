//
//  TextFieldItemCell.swift
//  Effeh
//
//  Created by Michael Attia on 6/27/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = self.frame.height / 2
        self.contentView.clipsToBounds = true
        contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func setupWith(keyword: String, background: UIColor, showRemoveButton: Bool){
        self.keywordLabel.text = keyword
        self.containerView.backgroundColor = background
        if !showRemoveButton{
            removeBtn?.removeFromSuperview()
        }
    }
    
}
