//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 范三球 on 2022/3/14.
//  带水印的内容
//

import SwiftUI

struct CustomTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
    }
}

extension View{
    func customTextStyled() -> some View{
        modifier(CustomTextStyle())
    }
}


struct Watermark: ViewModifier{
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View{
    func watermarked(with text: String) -> some View{
        modifier(Watermark(text: text))
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World!")
                .modifier(CustomTextStyle())
            Text("Other Hello World!")
                .customTextStyled()
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hello World!")
            Text("Oh my jesus")
                .frame(width: 300, height: 200)
                .watermarked(with: "Jesus")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
