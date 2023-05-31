//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Anthony Cifre on 5/25/23.
//
import CoreData
import SwiftUI

enum PredicateString {
    case beginsWith, contains
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    @FetchRequest(sortDescriptors: []) var singers: FetchedResults<Singer>
    
    @State private var predicateValue = ""
    @State private var predicate = PredicateString.beginsWith

    
    let predicateFilterOptions = [PredicateString.beginsWith, PredicateString.contains]
    
    
    var body: some View {
        VStack {
            FilteredView(predicate: predicate, filter: predicateValue)
            
            List(countries, id: \.self) { country in
                Section(country.wrappedFullName) {
                    ForEach(country.candyArray) { candy in
                        Text(candy.wrappedName)
                    }
                    .onDelete(perform: deleteCandy)
                    
                }
            }
            Picker("Type of Search", selection: $predicate) {
                ForEach(predicateFilterOptions, id: \.self) { filter in
                    Text(filter == PredicateString.beginsWith ? "Begins With" : "Contains")
                    
                }
            }
            TextField("Search", text: $predicateValue)
            
            
            
            Button("Add Example Candies") {
                
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? moc.save()
            }
            
            Button("Add Example Singers") {
                
                let singer1 = Singer(context: moc)
                singer1.firstName = "Beyonce"
                singer1.lastName = "Knowles"
                
                let singer2 = Singer(context: moc)
                singer2.firstName = "Taylor"
                singer2.lastName = "Swift"
                
                let singer3 = Singer(context: moc)
                singer3.firstName = "Kim"
                singer3.lastName = "Petras"
                
                try? moc.save()
            }
            
        }
        .padding()
    }
    
    func deleteCandy(at offsets: IndexSet) {
        
        for offset in offsets {
            let country = countries[offset]
            
            moc.delete(country)
        }
        try? moc.save()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
