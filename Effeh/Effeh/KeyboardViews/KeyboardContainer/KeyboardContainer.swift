//
//  KeyboardContainer.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardContainer: UIView {
    
    // MARK: - Constants
    private let nibFileName = String(describing: KeyboardContainer.self)
    private let editFieldCellId = "Edit_Field"
    private let searchItemCellId = "Search_Item"
    
    // MARK: - View Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var searchcollectionView: UICollectionView!{
        didSet{
            searchcollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            (searchcollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            searchcollectionView.delegate = self
            searchcollectionView.dataSource = self
            let editFieldNib = UINib(nibName: String(describing: TextEntryCollectionViewCell.self), bundle: nil)
            searchcollectionView.register(editFieldNib, forCellWithReuseIdentifier: editFieldCellId)
            let searchItemNib = UINib(nibName: String(describing: KeywordCollectionViewCell.self), bundle: nil)
            searchcollectionView.register(searchItemNib, forCellWithReuseIdentifier: searchItemCellId)
        }
    }
    @IBOutlet weak var searchFieldView: UIView!{
        didSet{
            searchFieldView.layer.borderColor = Colors.searchBarBorderColor.cgColor
            searchFieldView.layer.borderWidth = 2
        }
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView(){
        Bundle.main.loadNibNamed(nibFileName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
//
//let items = ["ايام سوده","عندها","من انتم","مش فاكرك ياض", "حاجه تانيه"]


// MARK: - Input search field
extension KeyboardContainer: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}
