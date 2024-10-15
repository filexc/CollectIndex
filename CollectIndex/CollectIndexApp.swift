//
//  CollectIndexApp.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 9/30/24.
//

import SwiftUI

@main
struct CollectIndexApp: App {
    @StateObject var collections = Collections()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collections)
        }
    }
}
