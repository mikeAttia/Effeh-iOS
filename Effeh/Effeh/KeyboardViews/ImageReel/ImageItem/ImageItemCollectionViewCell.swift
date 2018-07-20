//
//  ImageItemCollectionViewCell.swift
//  Effeh
//
//  Created by Michael Attia on 6/26/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageFetcher: class {
    func fetchMemeWith(id: String, completion: @escaping (Meme?) -> Void)
}

class ImageItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    weak var imageFetcher: ImageFetcher?
    var memeId: String?{
        didSet{
            imageView.kf.cancelDownloadTask()
            if let id = memeId{
                imageFetcher?.fetchMemeWith(id: id, completion: {[weak self] meme in
                    guard let meme = meme,
                        let urlStr = meme.url,
                        let url = URL(string: urlStr) else{
                        //FIXME: handle error in fetching meme data
                        return
                    }
                    self?.imageView.kf.setImage(with: url)
                })
            }
        }
    }
    var meme: Meme?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }

}
