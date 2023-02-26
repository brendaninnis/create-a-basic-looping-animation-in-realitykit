//
//  SpinnyDonutsApp.swift
//  Spinny Bagels
//
//  Created by Brendan Innis on 2023-02-25.
//

import SwiftUI

@main
struct SpinnyBagelsApp: App {
    @Environment(\.scenePhase) var scenePhase

    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("App did become active")
                        viewModel.resume()
                    case .inactive:
                        print("App did become inactive")
                        viewModel.pause()
                    default:
                        break
                    }
                }
        }
    }
}
