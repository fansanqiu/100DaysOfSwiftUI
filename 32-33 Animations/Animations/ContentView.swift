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
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    // 一种控制锚点的类型，内置`.topLeading`、`.bottomTrailing`、`.center`
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            // 旋转效果，类似`rotation3DEffect()`，唯一的区别就是`rotationEffect()`没有z轴
            .rotationEffect(.degrees(amount), anchor: anchor)
            // `clipped()`意味着当视图旋转时，位于其自然矩形之外的部分不会被绘制
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
