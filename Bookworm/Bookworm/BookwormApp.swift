//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Anthony Cifre on 5/23/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .preferredColorScheme(.dark)
        }
    }
}
