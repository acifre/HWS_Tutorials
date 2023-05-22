//
//  GridLayoutView.swift
//  Moonshot
//
//  Created by Anthony Cifre on 5/18/23.
//

import SwiftUI

struct GridLayoutView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        VStack {
                            MissionView(mission: mission, astronauts: astronauts)                            }
                        
                    } label: {
                        MissionDisplayView(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GridLayoutView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        GridLayoutView(missions: missions, astronauts: astronauts)
    }
}
