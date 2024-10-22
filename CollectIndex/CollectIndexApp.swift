//
//  CollectIndexApp.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 9/30/24.
//

import SwiftUI
import Foundation

@main
struct CollectIndexApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var collections = Collections()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collections)
                .task {
                    do {
                        try await collections.loadSavedData()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
        .onChange(of: scenePhase){
            if scenePhase == .background {
                collections.saveData()
            }
        }
    }
}
