//
//  ContentView.swift
//  custom shape tab
//
//  Created by Susumu Hoshikawa on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            // tab view.
            HStack {
                
                Spacer()
                
                ForEach(TabItem.allCases, id: \.self) { tabItem in
                    
                    Button(action: {}, label: {
                        Text(tabItem.rawValue.uppercased())
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    })
                    .frame(width: 100, height: 100)
                }
                
                Spacer()
            }
            .frame(height: 70)
            .background(
                Color.accentColor
                    .ignoresSafeArea()
            )
            
            // content body.
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TabItem: String, CaseIterable {
    
    case home
    case favorite
    case settings
    
    var imageName: String {
        switch self {
        case .home: return "house"
        case .favorite: return "suit.heart"
        case .settings: return "gearshape"
        }
    }
}
