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
    private var removeBtnAction: ((Keyword?) -> ())?
    var keyword: Keyword?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = self.frame.height / 2
        self.contentView.clipsToBounds = true
        contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func setupWith(keyword: Keyword, showRemoveButton: Bool, removeBtnAction: ((Keyword?) -> ())? = nil){
        self.keyword = keyword
        self.removeBtnAction = removeBtnAction
        self.keywordLabel.text = keyword.word
        self.containerView.backgroundColor = keyword.bgColor
        if !showRemoveButton{
            removeBtn?.removeFromSuperview()
        }
    }
    
    @IBAction func removeKeyword(_ sender: UIButton) {
        removeBtnAction?(keyword)
    }
    
    
}
