//
//  FileManager.swift
//  BucketList
//
//  Created by Anthony Cifre on 5/31/23.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

