//
//  KeyboardContainer.swift
//  Effeh
//
//  Created by Michael Attia on 6/22/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class KeyboardContainer: UIView {
    
    @IBOutlet var imgReel: ImageReel!{
        didSet{
            imgReel.imageFetcher = self
        }
    }
    // MARK: - Constants
    private let nibFileName = String(describing: KeyboardContainer.self)
    private let editFieldCellId = "Edit_Field"
    private let searchItemCellId = "Search_Item"
    fileprivate let dataStore = DataStore()
    
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
    
    fileprivate var keywordsList:[Keyword] = []
    weak var searchFieldCell: TextEntryCollectionViewCell?
    
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
        dataStore.initialize()
    }
    
    private var laidOut = false
    private var kb: KeyboardView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !laidOut{
            imgReel.removeFromSuperview()
            kb = KeyboardView(frame: contentContainer.bounds)
            contentContainer.addSubview(kb!)
            kb?.pinEdgesTo(contentContainer)
            kb?.delegate = self
            laidOut = !laidOut
        }
    }
    
}


// MARK: - Input search field
extension KeyboardContainer: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordsList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < keywordsList.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchItemCellId, for: indexPath) as! KeywordCollectionViewCell
            cell.setupWith(keyword: keywordsList[indexPath.row],
                           showRemoveButton: true) { keyword in
                            if let index = self.keywordsList.index(where: {$0.id == keyword?.id}){
                                self.keywordsList.remove(at: index)
                                let indexPath = IndexPath(item: index, section: 0)
                                self.searchcollectionView.deleteItems(at: [indexPath])
                            }
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: editFieldCellId, for: indexPath) as! TextEntryCollectionViewCell
            cell.textField.placeholder = "دور بالافيه"
            cell.setupCell(width: collectionView.frame.width * 0.66, height: collectionView.frame.height)
            self.searchFieldCell = cell
            return cell
        }
    }
}

// MARK: - KeyboardViewDelegate
extension KeyboardContainer: KeyboardViewDelegate{
    func userSelected(keyword: Keyword) {
        guard !keywordsList.contains(where: {$0.id == keyword.id}) else{return}
        keywordsList.append(keyword)
        let indexPath = IndexPath(item: keywordsList.count - 1, section: 0)
        searchcollectionView.insertItems(at: [indexPath])
        searchFieldCell?.textField.text = ""
    }
    
    func userTapped(key: KeyboardKey) {
        switch key.type {
        case .letter, .space:
            searchFieldCell?.insertCharacter(key.char)
        case .backspace:
            searchFieldCell?.deleteLastChar()
        case .return:
            // Hide keyboard view and clear its search results
            kb?.removeFromSuperview()
            kb?.keywordsList = []
            // show image reel view
            contentContainer.addSubview(imgReel)
            imgReel.pinEdgesTo(contentContainer)
            imgReel.memeIds = dataStore.getSortedMemesIdsWith(keywords: keywordsList)
        case .changeKeyboard:
            break
        }
        if let cue = searchFieldCell?.textField.text{
            dataStore.fetchKeywordsContaining(cue) { (keywords, err) in
                guard err == nil, let keywords = keywords else{
                    //FIXME: Handle error in retrieveing keywords
                    return
                }
                let filteredWords = keywords.filter({ (keyword) -> Bool in
                    return !(self.keywordsList.contains{$0.id == keyword.id})
                })
                kb?.keywordsList = filteredWords
            }
        }
        
    }
}

extension KeyboardContainer: ImageFetcher{
    func fetchMemeWith(id: String, completion: @escaping (Meme?) -> Void){
        dataStore.fetchMemeWith(id: id, completion: completion)
    }
}
