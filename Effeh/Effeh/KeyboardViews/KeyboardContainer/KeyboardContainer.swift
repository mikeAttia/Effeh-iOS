//
//  KeyboardContainer.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardContainer: UIView {
    
    @IBOutlet var imgReel: ImageReel!
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
    
    var keyboard: KeyboardContainer?
    
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
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var laidOut = false
    var kb: KeyboardView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !laidOut{
            imgReel.removeFromSuperview()
            kb = KeyboardView(frame: contentContainer.bounds)
            contentContainer.addSubview(kb!)
            kb?.pinEdgesTo(contentContainer)
            laidOut = !laidOut
        }
    }
    var viewingKB = true
    func isStillExist(){
        if viewingKB{
            kb?.removeFromSuperview()
            contentContainer.addSubview(imgReel)
            imgReel.pinEdgesTo(contentContainer)
        }else{
            imgReel.removeFromSuperview()
            contentContainer.addSubview(kb!)
            kb?.pinEdgesTo(contentContainer)
        }
        viewingKB = !viewingKB
    }
}


//
//let items = ["ايام سوده","عندها","من انتم","مش فاكرك ياض", "حاجه تانيه"]


// MARK: - Input search field
extension KeyboardContainer: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: editFieldCellId, for: indexPath) as! TextEntryCollectionViewCell
        cell.textField.placeholder = "دور بالافيه"
        cell.setupCell(width: collectionView.frame.width * 0.66, height: collectionView.frame.height)
        return cell
    }
}
