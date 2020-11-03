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
    // 選択中のタブ.
    @State private var selected: TabItem = .home
    
    var body: some View {
        
        VStack {
            
            // tab view.
            HStack {
                
                Spacer()
                
                ForEach(TabItem.allCases, id: \.self) { tabItem in
                    
                    GeometryReader { geometry in
                        
                        Button(action: {
                            withAnimation(
                                .interactiveSpring(
                                    response: 0.5, dampingFraction: 0.5, blendDuration: 0.5
                                )
                            ) {
                                // タップされたボタンのx軸中央を保持.
                                tabMidX = geometry.frame(in: .global).midX
                            }
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
                    .clipShape(TabShape(tabMidX: tabMidX))
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
    
    var tabMidX: CGFloat
    
    var animatableData: CGFloat {
        get { tabMidX }
        set { tabMidX = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            // 基本となる矩形.
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.closeSubpath()
            
            let curveWidth = rect.width / 10
            let curveHeight = rect.height / 5
            
            // 始点.
            path.move(to: CGPoint(x: tabMidX - curveWidth, y: rect.height))
            
            // 左半分.
            let to1 = CGPoint(x: tabMidX, y: rect.height - curveHeight)
            let ctrl1a = CGPoint(x: tabMidX - (curveWidth / 2), y: rect.height)
            let ctrl1b = CGPoint(x: tabMidX - (curveWidth / 2), y: rect.height - curveHeight)
            path.addCurve(to: to1, control1: ctrl1a, control2: ctrl1b)
            
            // 右半分.
            let to2 = CGPoint(x: tabMidX + curveWidth, y: rect.height)
            let ctrl2a = CGPoint(x: tabMidX + (curveWidth / 2), y: rect.height - curveHeight)
            let ctrl2b = CGPoint(x: tabMidX + (curveWidth / 2), y: rect.height)
            path.addCurve(to: to2, control1: ctrl2a, control2: ctrl2b)
        }
    }
}
