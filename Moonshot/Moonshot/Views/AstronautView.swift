//
//  AstronautView.swift
//  Moonshot
//
//  Created by Anthony Cifre on 5/18/23.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                RectangleDivider()
                    .padding(.horizontal)
                Text(astronaut.description)
                    .padding([.bottom, .leading, .trailing])
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"] ?? Astronaut(id: "Cifre", name: "Anthony Cifre", description: "Gay"))
            .preferredColorScheme(.dark)
    }
}
