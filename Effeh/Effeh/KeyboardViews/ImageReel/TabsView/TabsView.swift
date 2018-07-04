//
//  TabsView.swift
//  Effeh
//
//  Created by Michael Attia on 6/23/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

class TabsView: UIView {
    
    // MARK: - TabItems
    enum TabItems {
        case search
        case favorites
        case history
    }

    // MARK: - Constants
    private let nibFileName = String(describing: TabsView.self)
    
    // MARK: - View Outlets
    @IBOutlet var contentView: UIView!
    // Tabs
    @IBOutlet weak var nextKeyboardItem: TabItem!
    @IBOutlet private weak var searchTabItem: TabItem!{
        didSet{
            searchTabItem.addTarget(self, action: #selector(selectedItem(_:)), for: UIControlEvents.touchUpInside)
            searchTabItem.isSelected = true
        }
    }
   
    @IBOutlet private weak var favoritesTabItem: TabItem!{
        didSet{
            favoritesTabItem.addTarget(self, action: #selector(selectedItem(_:)), for: UIControlEvents.touchUpInside)
        }
    }

    @IBOutlet private weak var historyTabItem: TabItem!{
        didSet{
            historyTabItem.addTarget(self, action: #selector(selectedItem(_:)), for: UIControlEvents.touchUpInside)
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
    
    //MARK: - Tabs Selection
    var selectedTab: TabItems = .search {
        didSet{
            switch selectedTab {
            case .search:
                searchTabItem.isSelected = true
                favoritesTabItem.isSelected = false
                historyTabItem.isSelected = false
            case .favorites:
                searchTabItem.isSelected = false
                favoritesTabItem.isSelected = true
                historyTabItem.isSelected = false
            case .history:
                searchTabItem.isSelected = false
                favoritesTabItem.isSelected = false
                historyTabItem.isSelected = true
            }
            //TODO: Call the delegate to inform of the selected tab
        }
    }
    
    @objc private func selectedItem(_ item: TabItem){
        switch item {
        case searchTabItem:
            self.selectedTab = .search
        case favoritesTabItem:
            self.selectedTab = .favorites
        case historyTabItem:
            self.selectedTab = .history
        default: break
        }
    }

}
