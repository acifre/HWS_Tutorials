//
//  DataController.swift
//  Bookworm
//
//  Created by Anthony Cifre on 5/23/23.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm") // use bookworm data model we made
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
