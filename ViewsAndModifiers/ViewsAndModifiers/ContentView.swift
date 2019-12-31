//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Josh Hrach on 12/30/19.
//  Copyright © 2019 Random Projects, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        .makeBigBlue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BigBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func makeBigBlue() -> some View {
        self.modifier(BigBlue())
    }
}
