//
//  TabItem.swift
//  Effeh
//
//  Created by Michael Attia on 6/23/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class TabItem: UIButton {
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                self.imageView?.tintColor = Colors.selectedTabIconTint
                self.backgroundColor = Colors.selectedTabBackground
            }else{
                self.imageView?.tintColor = Colors.unselectedTabIconTint
                self.backgroundColor = Colors.unselectedTabBackground
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        self.setImage(self.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

}
