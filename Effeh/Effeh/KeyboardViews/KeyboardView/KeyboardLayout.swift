//
//  KeyboardKey.swift
//  Effeh
//
//  Created by Michael Attia on 7/3/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

struct KeyboardLayout{
    
    let keyboardRows: [[KeyboardKey]]
    
    static var arabicLayout: KeyboardLayout{
        return KeyboardLayout(keyboardRows: [
            [KeyboardKey(type: .letter, char: "ض", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ص", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ث", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ق", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ف", subCharacters: nil),
             KeyboardKey(type: .letter, char: "غ", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ع", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ه", subCharacters: nil),
             KeyboardKey(type: .letter, char: "خ", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ح", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ج", subCharacters: nil)
            ],
            [KeyboardKey(type: .letter, char: "ش", subCharacters: nil),
             KeyboardKey(type: .letter, char: "س", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ي", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ب", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ل", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ا", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ت", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ن", subCharacters: nil),
             KeyboardKey(type: .letter, char: "م", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ك", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ة", subCharacters: nil)
            ],
            [KeyboardKey(type: .letter, char: "ء", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ظ", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ط", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ذ", subCharacters: nil),
             KeyboardKey(type: .letter, char: "د", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ز", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ر", subCharacters: nil),
             KeyboardKey(type: .letter, char: "و", subCharacters: nil),
             KeyboardKey(type: .letter, char: "ى", subCharacters: nil),
             KeyboardKey(type: .backspace , char: "", subCharacters: nil),
             ],
            [KeyboardKey(type: .changeKeyboard, char: "", subCharacters: nil),
             KeyboardKey(type: .space, char: "", subCharacters: nil),
             KeyboardKey(type: .return, char: "شوف كده", subCharacters: nil)]
            ])
    }
}

struct KeyboardKey{
    enum KeyType{
        case letter
        case backspace
        case `return`
        case space
        case changeKeyboard
    }
    
    let type: KeyType
    let char: String
    let subCharacters: [Character]?
}
