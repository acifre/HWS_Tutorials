//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Anthony Cifre on 5/25/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController() // create instance of data controller
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // inject this into the environment of the app
                .preferredColorScheme(.dark)
            
        }
    }
}
