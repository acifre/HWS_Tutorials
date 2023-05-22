//
//  ContentView.swift
//  Moonshot
//
//  Created by Anthony Cifre on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingList = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingList {
                    ListLayoutView(missions: missions, astronauts: astronauts)
                    
                } else {
                    GridLayoutView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showingList.toggle()
                } label: {
                    Toggle(showingList ? "Grid View" : "List View", isOn: $showingList)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
