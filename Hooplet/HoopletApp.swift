//
//  HoopletApp.swift
//  Hooplet
//
//  Created by Phil Loden on 11/23/24.
//

import SwiftUI

@main
struct HoopletApp: App {
    var body: some Scene {
        WindowGroup {
            PopularMediaItemsView(dataSource: RemoteDataSource())
        }
    }
}
