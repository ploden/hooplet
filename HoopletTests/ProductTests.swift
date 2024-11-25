//
//  ProductTests.swift
//  HoopletTests
//
//  Created by Phil Loden on 11/23/24.
//

import Testing
import Foundation
@testable import Hooplet

struct ProductTests {

    @Test func testJSONDecoding() async throws {
        let jsonString =
"""
{
        "id": 1,
        "title": "The Grand Adventure",
        "author": "John Doe",
        "image_url": "https://via.placeholder.com/300x450?text=The+Grand+Adventure",
        "content_type": "movie"
      }
"""

        let jsonData = jsonString.data(using: .utf8)!
        let product = try! JSONDecoder().decode(MediaItem.self, from: jsonData)

        #expect(product.id == 1)
        #expect(product.title == "The Grand Adventure")
        #expect(product.author == "John Doe")
        #expect(product.imageURL == "https://via.placeholder.com/300x450?text=The+Grand+Adventure")
        #expect(product.contentType == .movie)
    }

}
