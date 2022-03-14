//
//  ContentView.swift
//  ScissorsPaperStone
//
//  Created by MacBook Air on 2022/3/14.
//

import SwiftUI

struct ContentView: View {
    @State private var options = ["✂️", "📄", "🪨"]
    
    var body: some View {
        VStack {
            Button("✂️"){ }
            Button("📄"){ }
            Button("🪨"){ }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
