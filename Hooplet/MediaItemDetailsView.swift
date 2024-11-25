//
//  MediaItemDetailsView.swift
//  Hooplet
//
//  Created by Phil Loden on 11/23/24.
//

import SwiftUI

struct MediaItemDetailsView: View {
    // iOS 17+, so avoid property wrapper
    private var dataSource: any MediaItemDataSourceProtocol
    @State var mediaItem: MediaItem
    @State var mediaItemDetails: MediaItemDetails?
    @State private var showingStartWatchingAlert = false

    internal init(dataSource: any MediaItemDataSourceProtocol, mediaItem: MediaItem) {
        self.dataSource = dataSource
        self.mediaItem = mediaItem
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: mediaItem.imageURL) {
                HStack {
                    Spacer()
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.black)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                        @unknown default:
                            Image(systemName: "exclamationmark.triangle")
                        }
                    }
                    .frame(width: 200, height: 200)
                    Spacer()
                }
            }
            HStack {
                Button(action: {
                    showingStartWatchingAlert = true
                }, label: {
                    Text("Play")
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                })
            }
            .background(.blue)
            .cornerRadius(10.0)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 15.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
            Text(mediaItem.contentTypeDisplayString)
                .font(Font.system(.footnote, weight: .medium))
                .foregroundColor(.black)
            Text(mediaItem.title)
                .font(Font.system(.title, weight: .medium))
                .foregroundColor(.black)
            Text("Writer: \(mediaItem.author)")
                .foregroundColor(.black)
            if let mediaItemDetails = mediaItemDetails {
                Text("Synopsis: \(mediaItemDetails.synopsis)")
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 44.0, leading: 15.0, bottom: 44.0, trailing: 15.0))
        .background(.white)
        .navigationTitle(mediaItem.title)
        .task {
            do {
                mediaItemDetails = try await dataSource.details(for: mediaItem)
            } catch { }
        }
        .alert("Start Watching \(mediaItem.title)", isPresented: $showingStartWatchingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    let mediaItem = MediaItem(id: 1, title: "A New Hope", author: "George Lucas", imageURL: "", contentType: .movie)
    MediaItemDetailsView(dataSource: PreviewDataSource(), mediaItem: mediaItem)
}
