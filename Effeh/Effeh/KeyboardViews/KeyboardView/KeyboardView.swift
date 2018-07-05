//
//  KeyboardView.swift
//  Effeh
//
//  Created by Michael Attia on 7/3/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    
    // MARK: - Constants
    private let searchItemCellId = "Search_Item"
    private let KeywordsViewHeight: CGFloat = 50
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
    
    // MARK: - Views
    lazy var keywordsView: UICollectionView = {
        let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: KeywordsViewHeight), collectionViewLayout: layout)
        view.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        view.delegate = self
        view.dataSource = self
        let searchItemNib = UINib(nibName: String(describing: KeywordCollectionViewCell.self), bundle: nil)
        view.register(searchItemNib, forCellWithReuseIdentifier: searchItemCellId)
        return view
    }()
    let keyboardKeysContainer = UIView()
    
    // MARK: - Initialization
    
    init(){
        super.init(frame: CGRect.zero)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView(){
        layoutKeys(containerView: keyboardKeysContainer)
        addSubViewsWithConstraints()
    }
    
    // MARK: - Subviews initialization
    private func addSubViewsWithConstraints(){
        self.addSubview(keywordsView)
        self.addSubview(keyboardKeysContainer)
        // KeywordsView constraints
        NSLayoutConstraint(item: keywordsView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: KeywordsViewHeight).isActive = true
        
        // Keyboards Container constraints
        NSLayoutConstraint(item: keyboardKeysContainer, attribute: .top, relatedBy: .equal, toItem: keywordsView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keyboardKeysContainer, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keyboardKeysContainer, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keyboardKeysContainer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keyboardKeysContainer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heightToFitKeyboardKeys()).isActive = true
    }
    
    private func layoutKeys(containerView: UIView){
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
                keyboardKeysContainer.addSubview(keyButton)
                //FIXME: ADD target or delegate to key
                currentXValue = currentXValue + keyButton.frame.width + keyPadding
            }
            currentYValue = currentYValue + keyHeight + keyPadding
        }
    }
    
    private func heightToFitKeyboardKeys() -> CGFloat{
        let rowsCount = CGFloat(layout.keyboardRows.count)
        return (rowsCount * keyHeight) + ((rowsCount + 1) * keyPadding)
    }
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}
