# SDSDiceView

## SwiftUI Dice view
can be triggered by using combine publisher

## example
```
//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2021/02/03
//  © 2021  SmallDeskSoftware
//

import SwiftUI
import Combine
import SDSDiceView

struct ContentView: View {
    @State private var dice1:Int = Int.random(in: 1...6)
    @State private var dice2:Int = Int.random(in: 1...6)
    @State private var dice3:Int = Int.random(in: 1...6)
    var requester = PassthroughSubject<Void,Never>()
    var body: some View {
        VStack {
            HStack {
                SDSDiceView($dice1, requester.eraseToAnyPublisher())
                SDSDiceView($dice2, requester.eraseToAnyPublisher())
                SDSDiceView($dice3, requester.eraseToAnyPublisher())
            }
            Text("\(dice1) - \(dice2) - \(dice3)")
            Button(action: {
                self.requester.send()
            }, label: {
                Text("Roll")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
