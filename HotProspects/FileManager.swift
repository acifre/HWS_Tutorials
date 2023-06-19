//
//  FileManager.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/18/23.
//

import Foundation
import SwiftUI

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}

