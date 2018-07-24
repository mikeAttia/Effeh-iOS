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
    private let padding: CGFloat = 10
    
    // MARK: - View Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tabsView: TabsView!
    @IBOutlet weak var imageReel: UICollectionView!{
        didSet{
            imageReel.delegate = self
            imageReel.dataSource = self
            imageReel.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 10)
            let imageItemNib = UINib(nibName: String(describing:ImageItemCollectionViewCell.self), bundle: nil)
            imageReel.register(imageItemNib, forCellWithReuseIdentifier: imageItemCellId)
        }
    }
    
    var memeIds: [String] = []{
        didSet{
            imageReel.reloadData()
            if memeIds.count > 0{
                imageReel.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    weak var imageFetcher: ImageFetcher?
    
    
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
    
    fileprivate func showCopiedHint(){
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.green.withAlphaComponent(0.9)
        let label = UILabel()
        label.text = "copied ✔︎"
        label.frame = view.frame
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
        self.addSubview(view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            view.removeFromSuperview()
        }
    }
}

extension ImageReel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageItemCellId, for: indexPath) as! ImageItemCollectionViewCell
        cell.imageFetcher = imageFetcher
        cell.memeId = memeIds[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 20
        let width = height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageItemCollectionViewCell
        if let img = cell?.imageView.image, let data = UIImagePNGRepresentation(img){
            UIPasteboard.general.setData(data, forPasteboardType: "public.png")
            showCopiedHint()
        }
    }
}
