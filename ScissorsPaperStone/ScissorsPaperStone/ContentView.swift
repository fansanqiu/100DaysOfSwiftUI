//
//  ContentView.swift
//  ScissorsPaperStone
//
//  Created by MacBook Air on 2022/3/14.
//

import SwiftUI

struct ContentView: View {
    @State private var pitOption = ["Scissors", "Paper", "Stone"]
    
    var body: some View {
        VStack {
            Button("Scissors", action: clickScissors)
            Button("Paper", action: clickPaper)
            Button("Stone", action: clickStone)
        }
    }
    func clickScissors(){
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
