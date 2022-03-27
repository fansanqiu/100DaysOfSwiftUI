//
//  ContentView.swift
//  Animations
//
//  Created by MacBook Air on 2022/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                // do nothing
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .opacity(0.2)
                    .frame(width: 200, height: 200)
                    // 创建一个非对称过渡，在出现的时候使用放大，在移除时候使用透明度
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    // 创建一个放大过渡
                    .transition(.scale)
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
