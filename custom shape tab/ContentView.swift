//
//  ContentView.swift
//  custom shape tab
//
//  Created by Susumu Hoshikawa on 2020/11/02.
//

import SwiftUI

struct ContentView: View {
    
    // 選択中のタブのx軸中央.
    @State private var tabMidX: CGFloat = 0
    
    var body: some View {
        
        VStack {
            
            // tab view.
            HStack {
                
                Spacer()
                
                ForEach(TabItem.allCases, id: \.self) { tabItem in
                    
                    GeometryReader { geometry in
                        
                        Button(action: {
                            // タップされたボタンのx軸中央を保持.
                            tabMidX = geometry.frame(in: .global).midX
                        }, label: {
                            Text(tabItem.rawValue.uppercased())
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        })
                        // frameはGeometryReaderに従う.
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                        .onAppear {
                            // 初期表示時のみ、一番左のタブのポジションを保持.
                            if tabItem == TabItem.allCases.first {
                                tabMidX = geometry.frame(in: .global).midX
                            }
                        }
                    }
                    // frameはGeometryReaderで定義.
                    .frame(width: 100, height: 100)
                }
                
                Spacer()
            }
            .frame(height: 70)
            .background(
                Color.accentColor
                    .clipShape(TabShape())
                    .ignoresSafeArea()
            )
            
            // content body.
            Spacer()
            
            // debug.
            Text("\(tabMidX)")
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

struct TabShape: Shape {
    func path(in rect: CGRect) -> Path {
        Capsule().path(in: rect)
    }
}
