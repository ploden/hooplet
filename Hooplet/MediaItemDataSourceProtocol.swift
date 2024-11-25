//
//  MediaItemDataSourceProtocol.swift
//  Hooplet
//
//  Created by Phil Loden on 11/24/24.
//

protocol MediaItemDataSourceProtocol {
    func popular() async throws -> [MediaItem]
    func details(for item: MediaItem) async throws -> MediaItemDetails
}
