//
//  Extensions.swift
//  Bookworm
//
//  Created by Anthony Cifre on 5/25/23.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
