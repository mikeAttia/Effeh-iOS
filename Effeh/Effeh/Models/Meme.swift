//
//  Meme.swift
//  Effeh
//
//  Created by Michael Attia on 7/12/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

struct Meme {
    let id: String
    let url: String?
    let keywordsIds: [String]
    let ownerId: String?
    
    init(id: String, dict: [String: Any]) {
        self.id = id
//        self.url = dict["url"] as? String
        self.url = "https://akphoto1.ask.fm/054/623/551/1280003009-1r8q7ak-673jsbr28npf8a/original/1545191_203092639896535_1398971751_n.jpg"
        self.keywordsIds = (dict["keywords"] as? [String]) ?? []
        self.ownerId = dict["owner"] as? String
     }
}
