//
//  ContentView.swift
//  WordScramble
//
//  Created by 范三球 on 2022/3/18.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            // we found the file in our bundle!
        }
        
        if let fileContents = try? String(contentsOf: fileURL) {
            // we loaded the file into a string!
        }
        
        List {
            Text("Static Row")

            ForEach(people, id: \.self) {
                Text($0)
            }

            Text("Static Row")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
