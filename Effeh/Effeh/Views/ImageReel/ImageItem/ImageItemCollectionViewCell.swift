//
//  ImageItemCollectionViewCell.swift
//  Effeh
//
//  Created by Michael Attia on 6/26/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class ImageItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }

}
