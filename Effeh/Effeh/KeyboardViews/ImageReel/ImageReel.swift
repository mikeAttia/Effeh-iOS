//
//  ImageReel.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class ImageReel: UIView {

    // MARK: - Constants
    private let nibFileName = String(describing: ImageReel.self)
    private let imageItemCellId = "Image_Item"
    
    // MARK: - View Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tabsView: TabsView!
    @IBOutlet weak var imageReel: UICollectionView!{
        didSet{
            imageReel.delegate = self
            imageReel.dataSource = self
            let imageItemNib = UINib(nibName: String(describing:ImageItemCollectionViewCell.self), bundle: nil)
            imageReel.register(imageItemNib, forCellWithReuseIdentifier: imageItemCellId)
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

extension ImageReel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageItemCellId, for: indexPath) as! ImageItemCollectionViewCell
        cell.imageView.image = #imageLiteral(resourceName: "globe")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 20
        let width = height
        return CGSize(width: width, height: height)
    }
}
