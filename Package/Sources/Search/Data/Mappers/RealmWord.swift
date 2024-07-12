//
//  RealmWord.swift
//
//
//  Created by AmrFawaz on 12/07/2024.
//

import Foundation
import RealmSwift

class RealmWord: Object, Codable {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var word: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RealmWord {
    convenience init(word: Word) {
        self.init()
        self.id = word.id
        self.word = word.word
    }
}

extension Word {
    init(realmWord: RealmWord) {
        self.id = realmWord.id
        self.word = realmWord.word
        self.phonetic = ""
        self.meanings = []
    }
}
