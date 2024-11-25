//
//  PopularMediaItemsViewPreviews.swift
//  Hooplet
//
//  Created by Phil Loden on 11/25/24.
//

import SwiftUI

class PreviewDataSource: Observable, MediaItemDataSourceProtocol {
    func details(for item: MediaItem) async throws -> MediaItemDetails {
        let jsonString =
        """
        {
          "title": {
            "id": 1,
            "title": "The Grand Adventure",
            "author": "John Doe",
            "image_url": "https://via.placeholder.com/300x450?text=The+Grand+Adventure",
            "content_type": "movie",
            "synopsis": "Join a brave explorer on a thrilling quest through uncharted lands to uncover hidden treasures and ancient secrets."
          }
        }        
        """

        let data = jsonString.data(using: .utf8)!

        let decoder = JSONDecoder()

        struct ItemDetailResponse: Decodable {
            let title: MediaItemDetails
        }

        let json = try! decoder.decode(ItemDetailResponse.self, from: data)
        return json.title
    }

    func popular() async throws -> [MediaItem] {
        let jsonString =
        """
        {
          "popular": [
            {
              "id": 1,
              "title": "The Grand Adventure",
              "author": "John Doe",
              "image_url": "https://via.placeholder.com/300x450?text=The+Grand+Adventure",
              "content_type": "movie"
            },
            {
              "id": 2,
              "title": "Mystery of the Lost City",
              "author": "Jane Smith",
              "image_url": "https://via.placeholder.com/300x450?text=Mystery+of+the+Lost+City",
              "content_type": "audiobook"
            },
            {
              "id": 3,
              "title": "Future Horizons",
              "author": "Emily Johnson",
              "image_url": "https://via.placeholder.com/300x450?text=Future+Horizons",
              "content_type": "comic"
            },
            {
              "id": 4,
              "title": "The Shadow Hunter",
              "author": "Michael Brown",
              "image_url": "https://via.placeholder.com/300x450?text=The+Shadow+Hunter",
              "content_type": "tv"
            },
            {
              "id": 5,
              "title": "Journey Beyond the Stars",
              "author": "Laura Wilson",
              "image_url": "https://via.placeholder.com/300x450?text=Journey+Beyond+the+Stars",
              "content_type": "music"
            },
            {
              "id": 6,
              "title": "Echoes of Time",
              "author": "Chris Taylor",
              "image_url": "https://via.placeholder.com/300x450?text=Echoes+of+Time",
              "content_type": "movie"
            }
          ]
        }
        """

        let data = jsonString.data(using: .utf8)!

        let decoder = JSONDecoder()

        struct PopularItemsResponse: Decodable {
            let popular: [MediaItem]
        }

        let json = try! decoder.decode(PopularItemsResponse.self, from: data)
        return json.popular
    }
}

#Preview("Use_local") {
    PopularMediaItemsView(dataSource: PreviewDataSource())
}

#Preview("Use_API") {
    PopularMediaItemsView(dataSource: RemoteDataSource())
}
