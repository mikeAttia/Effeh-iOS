//
//  DataStore.swift
//  Effeh
//
//  Created by Michael Attia on 7/12/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Kingfisher

typealias JSON = [String: AnyObject]

class DataStore{
    
    private var firebaseStoreRef: DatabaseReference!
    private var keywordsList: [Keyword] = []
    
    func initialize(){
        // Configure Firebase if not configured
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        
        // Login user if not logged in
        if Auth.auth().currentUser == nil{
            //TODO: signInUserFromApp
            Auth.auth().signInAnonymously { (result, error) in
                print(result)
                print(error)
                //TODO: Check and react to signin result
            }
        }
        
        // Fetch keywords list
        firebaseStoreRef = Database.database().reference()
        fetchListOfKeywords()
        
        // Limit Kingfisher Cache to 50 megabytes
        ImageCache.default.maxDiskCacheSize = 50 * 1024 * 1024
        ImageCache.default.maxMemoryCost = 50 * 1024 * 1024
    }
    
    var userLoggedIn: Bool{
        guard let user = Auth.auth().currentUser else{
            return false
        }
        return !user.isAnonymous
    }
}

// MARK: - Keywords Data Operations
extension DataStore{
    
    private func fetchListOfKeywords(){
        firebaseStoreRef.child("keywords").observeSingleEvent(of: .value, with: { snapShot in
            let keywordsDict = snapShot.value as? NSDictionary
            self.keywordsList = Keyword.keywordsListFrom(keywordsDict)
        }) { err in
            //TODO: Handle Error in reading keywords list
            print(err)
        }
    }
    
    func fetchKeywordsContaining(_ cue: String, completion: ( [Keyword]?, Error? ) -> Void) {
        completion(keywordsList.filter{$0.word.contains(cue)}, nil)
    }
}

// MARK: - Memes Data Operations
extension DataStore{
    
    func getSortedMemesIdsWith(keywords: [Keyword]) -> [String] {
        let fullList = keywords.reduce([], { (list, keyword) -> [String] in
            var list = list
            list.append(contentsOf: keyword.memeIds)
            return list
        })
        let countedList = NSCountedSet(array: fullList)
        return countedList.objectEnumerator().allObjects
            .map{(id: $0 as! String, count: countedList.count(for: $0))}
            .sorted{$0.count > $1.count}
            .map{$0.id}
    }
    
    func fetchMemeWith(id: String, completion: @escaping (Meme?) -> Void){
        firebaseStoreRef.child("memes").child(id).observeSingleEvent(of: .value) { snapShot in
            if let data = snapShot.value as? NSDictionary, let json = data as? [String: Any]{
                completion(Meme(id: id, dict: json))
            }else{
                //FIXME: Fix error and send it to callback
                completion(nil)
            }
        }
    }
    
    func getUserFavMemes() -> [Meme] {
        //FIXME: implement
        return []
    }
    
    func getMostRecentMemes() -> [Meme] {
        //FIXME: implement
        return []
    }
}

