//
//  Product.swift
//  Hooplet
//
//  Created by Phil Loden on 11/23/24.
//

import Foundation
import UIKit

enum MediaContentType: String, Codable {
    case movie = "movie"
    case audiobook = "audiobook"
    case comic = "comic"
    case tv = "tv"
    case music = "music"
}

struct MediaItem: Identifiable {
    let id: Int
    let title: String
    let author: String
    let imageURL: String
    let contentType: MediaContentType
    var contentTypeDisplayString: String {
        return "\(contentType.rawValue.capitalized)"
    }
}

extension MediaItem: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case imageURL = "image_url"
        case contentType = "content_type"
    }
}
