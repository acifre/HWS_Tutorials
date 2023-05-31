//
//  FilteredView.swift
//  CoreDataProject
//
//  Created by Anthony Cifre on 5/26/23.
//

import SwiftUI

struct FilteredView: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(predicate: PredicateString ,filter: String) {
        
        var predicateString: String {
            switch predicate {
            case .beginsWith:
                return "BEGINSWITH[c]"
            case .contains:
                return "CONTAINS[c]"
            }
        }

        
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName \(predicateString) %@", filter))

    }
}

struct FilteredView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredView(predicate: .beginsWith, filter: "S")
    }
}
