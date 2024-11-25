//
//  PopularMediaItemsView.swift
//  Hooplet
//
//  Created by Phil Loden on 11/23/24.
//

import SwiftUI

struct PopularMediaItemsView: View {
    enum ViewState {
        case loading
        case loadingError
        case didLoad
    }

    // iOS 17+, so avoid property wrapper
    private var dataSource: any MediaItemDataSourceProtocol
    @MainActor
    @State private var items: [MediaItem]?
    @MainActor
    @State private var viewState: ViewState = .loading
    @State var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20.0), count: 2)

    internal init(dataSource: any MediaItemDataSourceProtocol) {
        self.dataSource = dataSource
        configureNavigationBar()
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [:]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func refresh() {
        viewState = .loading
        
        Task {
            do {
                items = try await dataSource.popular()
                viewState = .didLoad
            } catch {
                viewState = .loadingError
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if let items = self.items {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20.0) {
                            ForEach(items, id: \.id) { item in
                                NavigationLink(destination: MediaItemDetailsView(dataSource: self.dataSource, mediaItem: item)) {
                                    MediaItemCellView(mediaItem: item)
                                        .aspectRatio(2/3, contentMode: .fit)
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                    .padding(.horizontal)
                } else {
                    switch self.viewState {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.black)
                    case .loadingError:
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(Font.system(.title, weight: .light))
                                .foregroundColor(.black)
                            Button(action: {
                                refresh()
                            }, label: {
                                Text("Retry")
                                    .foregroundColor(.black)
                            })
                        }
                    default:
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Popular")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.white)
        .task {
            refresh()
        }
    }
}
