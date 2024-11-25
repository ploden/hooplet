//
//  MediaItemCellView.swift
//  Hooplet
//
//  Created by Phil Loden on 11/25/24.
//

import SwiftUI

struct MediaItemCellView: View {
    @State var mediaItem: MediaItem

    var body: some View {
        VStack {
            if let url = URL(string: mediaItem.imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .font(Font.system(.title, weight: .light))
                            .foregroundColor(.white)
                    @unknown default:
                        Image(systemName: "exclamationmark.triangle")
                            .font(Font.system(.title, weight: .light))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.15))
            } else {
                Spacer()
                    .background(.pink)
            }
            VStack {
                Text(mediaItem.contentTypeDisplayString)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(.footnote, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(mediaItem.title + "\n")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(Font.system(.body, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .fixedSize(horizontal: false, vertical: true)
                Text(mediaItem.author)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(.footnote, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .padding(EdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0))
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(10.0)
        .clipped()
        .shadow(color: .gray.opacity(0.35), radius: 2, x: 1, y: 1)
    }
}
