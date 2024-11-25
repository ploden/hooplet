//
//  MediaItemDetails.swift
//  Hooplet
//
//  Created by Phil Loden on 11/24/24.
//

import Foundation

struct MediaItemDetails: Identifiable {
    let id: Int
    let title: String
    let author: String
    let imageURL: String
    let contentType: MediaContentType
    let synopsis: String
}

extension MediaItemDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case imageURL = "image_url"
        case contentType = "content_type"
        case synopsis
    }
}
