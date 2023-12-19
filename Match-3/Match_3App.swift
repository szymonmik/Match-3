//
//  Match_3App.swift
//  Match-3
//
//  Created by Szymon Mikolajczuk on 10/12/2023.
//

import SwiftUI

@main
struct Match_3App: App {
    @StateObject var game = MatchGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
