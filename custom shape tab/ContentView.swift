//
//  ContentView.swift
//  custom shape tab
//
//  Created by Susumu Hoshikawa on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TabItem: String, CaseIterable {
    case home = "house"
    case favorite = "suit.heart"
    case settings = "gearshape"
}
