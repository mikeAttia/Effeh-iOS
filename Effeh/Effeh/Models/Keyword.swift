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
        guard let dict = json, let json = dict as? [String: Any] else {return []}
        var keywordsList: [Keyword] = []
        for key in json.keys{
            if let obj = json[key] as? [String: Any]{
                let word = obj["keyword"] as! String
                let memeIds = obj["memes"] as! [String]
                keywordsList.append(Keyword(word: word, id: key, memeIds: memeIds))
            }
        }
        return keywordsList
    }
    
}
