//
//  Comment.swift
//  LambdaTimeline
//
//  Created by Spencer Curtis on 10/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Comment: FirebaseConvertible, Equatable {
    
    static private let textKey = "text"
    static private let audioKey = "audio"
    static private let author = "author"
    static private let timestampKey = "timestamp"
    
    let text: String?
    let audio: Audio
    let author: Author
    let timestamp: Date
    
    init(text: String, audio: Audio, author: Author, timestamp: Date = Date()) {
        self.text = text
        self.audio = audio
        self.author = author
        self.timestamp = timestamp
    }
    
    init?(dictionary: [String : Any]) {
        guard let text = dictionary[Comment.textKey] as? String,
            
            let audioDictionary = dictionary[Comment.audioKey] as? [String: Any],
            let audio = Audio(dictionary: audioDictionary),
            let authorDictionary = dictionary[Comment.author] as? [String: Any],
            let author = Author(dictionary: authorDictionary),
            let timestampTimeInterval = dictionary[Comment.timestampKey] as? TimeInterval else { return nil }
        
        self.text = text
        self.audio = audio
        self.author = author
        self.timestamp = Date(timeIntervalSince1970: timestampTimeInterval)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [Comment.textKey: text ?? "",
                Comment.audioKey: audio,
                Comment.author: author.dictionaryRepresentation,
                Comment.timestampKey: timestamp.timeIntervalSince1970]
    }
}
