//
//  Item.swift
//  demo_test
//
//  Created by Chuci Chen on 1/14/25.
//

import Foundation
import SwiftData

@Model
final class JournalEntry {
    var id: UUID
    var timestamp: Date
    var messages: [JournalMessage]
    var summary: String?
    var isCompleted: Bool
    
    init(timestamp: Date = Date()) {
        self.id = UUID()
        self.timestamp = timestamp
        self.messages = []
        self.summary = nil
        self.isCompleted = false
    }
}

// Represents a single message in the journal dialogue
struct JournalMessage: Codable, Hashable {
    var id: UUID
    var content: String
    var type: MessageType
    var timestamp: Date
    var mediaURL: URL?
    
    enum MessageType: String, Codable {
        case text
        case image
        case voice
    }
}
