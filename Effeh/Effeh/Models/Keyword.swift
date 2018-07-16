//
//  Keyword.swift
//  Effeh
//
//  Created by Michael Attia on 7/12/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

struct Keyword {
    
    var word: String
    var id: String
    var memeIds: [String] = []
    
    static func keywordsListFrom(_ json: NSDictionary?) -> [Keyword]{
        //TODO: Parse Dictionary into list of Keyword objects
        return []
    }
    
}
