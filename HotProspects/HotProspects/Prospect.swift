//
//  Prospect.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/16/23.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false


}

@MainActor class Prospects: ObservableObject {

    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    var sortBy: SortType = .name

    enum SortType {
        case name, dateAdded
    }


    init() {
        let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent(saveKey)

        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print("Unable to load saved data.")
        }

        people = []

    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }


    private func save() {
        do {
            let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }

    }



}
