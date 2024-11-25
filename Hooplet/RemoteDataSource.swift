//
//  RemoteDataSource.swift
//  Hooplet
//
//  Created by Phil Loden on 11/24/24.
//

import Foundation

class RemoteDataSource {}

extension RemoteDataSource: MediaItemDataSourceProtocol {

    func details(for item: MediaItem) async throws -> MediaItemDetails {
        guard let url = URL(string: "https://midwest-tape.github.io/iOS-coding-challenge/title/\(item.id).json") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        struct ItemDetailResponse: Decodable {
            let title: MediaItemDetails
        }

        if let json = try? decoder.decode(ItemDetailResponse.self, from: data) {
            return json.title
        } else {
            throw URLError(.cannotParseResponse)
        }
    }

    func popular() async throws -> [MediaItem] {
        guard let url = URL(string: "https://midwest-tape.github.io/iOS-coding-challenge/popular.json") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        struct PopularItemsResponse: Decodable {
            let popular: [MediaItem]
        }

        if let json = try? decoder.decode(PopularItemsResponse.self, from: data) {
            return json.popular
        } else {
            throw URLError(.cannotParseResponse)
        }
    }

}
