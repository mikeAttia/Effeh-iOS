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
    }
    
    private func fetchListOfKeywords(){
        firebaseStoreRef.child("keywords").observeSingleEvent(of: .value, with: { snapShot in
            let keywordsDict = snapShot.value as? NSDictionary
            self.keywordsList = Keyword.keywordsListFrom(keywordsDict)
        }) { err in
            //TODO: Handle Error in reading keywords list
            print(err)
        }
    }
    
    var userLoggedIn: Bool{
        guard let user = Auth.auth().currentUser else{
            return false
        }
        return !user.isAnonymous
    }
    
    func getKeywordsContaining(_ cue: String) -> [Keyword] {
        return keywordsList.filter{$0.word.contains(cue)}
    }
    
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
    
    func getUserFavMemes() -> [Meme] {
        //FIXME: implement
        return []
    }
    
    func getMostRecentMemes() -> [Meme] {
        //FIXME: implement
        return []
    }
    
    
}
