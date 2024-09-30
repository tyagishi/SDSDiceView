//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2024/09/30
//  © 2024  SmallDeskSoftware
//

import SwiftUI
import SDSDiceView
import Combine

struct ContentView: View {
    @State private var dice1 = 1
    @State private var dice2 = 2
    
    let roll: PassthroughSubject<Void,Never> = PassthroughSubject()
    
    var body: some View {
        VStack {
            SDSDiceView($dice1, roll.eraseToAnyPublisher())
            SDSDiceView($dice2, roll.eraseToAnyPublisher())
            Button(action: { roll.send() }, label: { Text("Roll!") })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
