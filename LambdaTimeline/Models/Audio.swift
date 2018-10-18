//
//  Audio.swift
//  LambdaTimeline
//
//  Created by David Doswell on 10/16/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Audio: FirebaseConvertible, Equatable {
    
    static private let audioKey = "audio"
    static private let author = "author"
    static private let timestampKey = "timestamp"
    
    let author: Author
    let timestamp: Date
    
    init(author: Author, timestamp: Date = Date()) {
        self.author = author
        self.timestamp = timestamp
    }
    
    init?(dictionary: [String : Any]) {
        guard let authorDictionary = dictionary[Audio.author] as? [String: Any],
            let author = Author(dictionary: authorDictionary),
            let timestampTimeInterval = dictionary[Audio.timestampKey] as? TimeInterval else { return nil }
        
        self.author = author
        self.timestamp = Date(timeIntervalSince1970: timestampTimeInterval)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [Audio.author: author.dictionaryRepresentation,
                Audio.timestampKey: timestamp.timeIntervalSince1970]
    }
    
}
