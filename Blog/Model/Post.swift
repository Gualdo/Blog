//
//  Post.swift
//  Blog
//
//  Created by Eduardo David De La Cruz Marrero on 1/10/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

// Post Model...

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var postContent: [PostContent]
    var date: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case postContent
        case date
    }
}

// Post content model...

struct PostContent: Identifiable, Codable {
    var id = UUID().uuidString
    var value: String
    var type: PostType
    // For height
    // Only for UI not for backend
    var height: CGFloat = 0
    var showImage: Bool = false
    
    enum CodigKeys: String, CodingKey {
        case id
        // Since firestore keyname is key...
        case type = "key"
        case value
    }
}

// Content type...
// Eg Header, Paragraph...

enum PostType: String, CaseIterable, Codable {
    case Header = "Header"
    case SubHeading = "SubHeading"
    case Paragraph = "Paragraph"
    case Image = "Image"
}
