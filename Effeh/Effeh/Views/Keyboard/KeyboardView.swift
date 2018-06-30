//
//  KeyboardView.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    // MARK: - Constants
    let nibFileName = String(describing: KeyboardView.self)
    let editFieldCellId = "Edit_Field"
    let searchItemCellId = "Search_Item"
    
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
            searchFieldView.layer.borderColor = UIColor.lightGray.cgColor
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
        let imageReelView = ImageReel(frame: self.bounds)
        self.contentContainer.addSubview(imageReelView)
        imageReelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: imageReelView, attribute: .top, relatedBy: .equal, toItem: contentContainer, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageReelView, attribute: .bottom, relatedBy: .equal, toItem: contentContainer, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageReelView, attribute: .leading, relatedBy: .equal, toItem: contentContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageReelView, attribute: .trailing, relatedBy: .equal, toItem: contentContainer, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
}

let items = ["ايام سوده","عندها","من انتم","مش فاكرك ياض", "حاجه تانيه"]

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == items.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: editFieldCellId, for: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchItemCellId, for: indexPath) as! KeywordCollectionViewCell
            cell.contentView.backgroundColor = .red
            cell.keywordLabel.text = items[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat
        let width: CGFloat
        if indexPath.row == items.count{
            height = collectionView.frame.height
            width = collectionView.frame.width / 2
        }else{
            height = collectionView.frame.height - 10
            width = 100
        }
        return CGSize(width: width, height: height)
    }
}
