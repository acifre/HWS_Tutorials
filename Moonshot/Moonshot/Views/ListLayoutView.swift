//
//  ListLayoutView.swift
//  Moonshot
//
//  Created by Anthony Cifre on 5/18/23.
//

import SwiftUI

struct ListLayoutView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    VStack {
                        MissionView(mission: mission, astronauts: astronauts)                            }
                } label: {
                    MissionDisplayView(mission: mission)
                }
                .listRowBackground(Color.darkBackground)
            }
        }
        .listStyle(.plain)
    }
}

struct ListLayoutView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListLayoutView(missions: missions, astronauts: astronauts)
    }
}
