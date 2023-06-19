//
//  ContentView.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/7/23.
//

import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ContentView: View {

    @StateObject var prospects = Prospects()

    var body: some View {
        TabView {
            ProspectsView(filterType: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filterType: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filterType: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
        .preferredColorScheme(.dark)
    }
}

//#Preview {
//    ContentView()
//}
