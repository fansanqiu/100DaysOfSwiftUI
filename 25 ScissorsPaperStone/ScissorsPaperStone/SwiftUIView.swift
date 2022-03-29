//
//  SwiftUIView.swift
//  ScissorsPaperStone
//
//  Created by 范三球 on 2022/3/15.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var tap = false
    
    var body: some View {
        Button("Hello, World!")
            .alert("Click the alert", isPresented: $tap)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
