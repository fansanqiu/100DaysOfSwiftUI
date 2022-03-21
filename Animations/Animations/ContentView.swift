//
//  ContentView.swift
//  Animations
//
//  Created by MacBook Air on 2022/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
            // do nothing
//            animationAmount += 1
        }
        .padding(50)
        // 按钮背景色为`.red`
        .background(.red)
        // 文字颜色为`.white`
        .foregroundColor(.white)
        // 裁剪形状为`Circle()`
        .clipShape(Circle())
        // 缩放`animationAmount`倍
//        .scaleEffect(animationAmount)
        // 高斯模糊，`radius: (animationAmount - 1) * 3`表示模糊半径从0（无模糊）开始，然后变为3、6、9...
//        .blur(radius: (animationAmount - 1) * 3)
        .overlay(
            Circle()
            .stroke(.red)
            .scaleEffect(animationAmount)
            // 不透明度变化
            .opacity(2 - animationAmount)
            .animation(
                .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                value: animationAmount
            )
        )
        // 程序运行时执行
        .onAppear {
            animationAmount = 2
        }
        
        
        // `.repeatForever(autoreverses: true)`无限重复
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: true),
            value: animationAmount
        )
        // 为`animationAmount`属性的改变，添加一个`.default`的过渡动画。由于SwiftUI的代码执行是逐个执行的，添加动画必须要放在被改变属性的最后
        .animation(.default, value: animationAmount)
        // `.easeOut`缓出动画
        .animation(.easeOut, value: animationAmount)
        // `.interpolatingSpring(stiffness: 50, damping: 1)`弹跳动画，刚性为50，阻尼为1
        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        // 缓入缓出动画，`duration: 2`持续时间为2s
        .animation(.easeInOut(duration: 2), value: animationAmount)
        // `.delay(1)`延迟1s后执行
        .animation(
            .easeInOut(duration: 2)
                .delay(1),
            value: animationAmount
        )
        // 重复3次，`autoreverses: true`开启反复（当重复为2次时，会先放大，然后恢复默认，然后突然跳到放大）。`autoreverses: false`关闭反复（重复放大3次，每次都从默认值开始）
        .animation(
            .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: false),
            value: animationAmount
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
