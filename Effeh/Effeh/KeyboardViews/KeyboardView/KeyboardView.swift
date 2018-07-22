//
//  KeyboardView.swift
//  Effeh
//
//  Created by Michael Attia on 7/3/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

protocol KeyboardViewDelegate: KeyboardkeyButtonListener {
    func userSelected(keyword: Keyword)
}

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
    weak var delegate: KeyboardViewDelegate?
    var keywordsList: [Keyword] = []{
        didSet{
            keywordsView.reloadData()
        }
    }
    
    // MARK: - Views
    lazy var keywordsView: UICollectionView = {
        let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: KeywordsViewHeight), collectionViewLayout: layout)
        view.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        view.delegate = self
        view.dataSource = self
        let searchItemNib = UINib(nibName: String(describing: KeywordCollectionViewCell.self), bundle: nil)
        view.register(searchItemNib, forCellWithReuseIdentifier: searchItemCellId)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.groupTableViewBackground
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
        self.backgroundColor = UIColor.groupTableViewBackground
    }
    
    // MARK: - Subviews initialization
    private func addSubViewsWithConstraints(){
        self.addSubview(keywordsView)
        self.addSubview(keyboardKeysContainer)
        translatesAutoresizingMaskIntoConstraints = false
        // KeywordsView constraints
        keywordsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: keywordsView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -12).isActive = true
        NSLayoutConstraint(item: keywordsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: KeywordsViewHeight).isActive = true
        
        // Keyboards Container constraints
        keyboardKeysContainer.translatesAutoresizingMaskIntoConstraints = false
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
                    let changeLangWidth = keyWidth * 1.5
                    let cancelWidth = keyWidth * 1.5
                    let x = (keyPadding * 3) + changeLangWidth + cancelWidth
                    let width = UIScreen.main.bounds.width - (returnWidth + changeLangWidth + cancelWidth) - (keyPadding * 5)
                    keyButton = KeyboardkeyButton(frame: CGRect(x: x,
                                                                y: currentYValue,
                                                                width: width,
                                                                height: keyHeight),
                                                  key: key)
                case .changeKeyboard:
                    keyButton = KeyboardkeyButton(frame: CGRect(x: currentXValue,
                                                                y: currentYValue,
                                                                width: keyWidth * 1.5,
                                                                height: keyHeight),
                                                  key: key)
                case .cancel:
                    keyButton = KeyboardkeyButton(frame: CGRect(x: currentXValue,
                                                                y: currentYValue,
                                                                width: keyWidth * 1.5,
                                                                height: keyHeight),
                                                  key: key)
                }
                keyButton.listener = self
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
        return keywordsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchItemCellId, for: indexPath) as! KeywordCollectionViewCell
        cell.setupWith(keyword: keywordsList[indexPath.row], showRemoveButton: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let keyword = keywordsList[indexPath.row]
        delegate?.userSelected(keyword: keyword)
        self.keywordsList = []
        collectionView.reloadData()
    }
}

extension KeyboardView: KeyboardkeyButtonListener {
    func userTapped(key: KeyboardKey) {
        delegate?.userTapped(key: key)
    }
        
}
