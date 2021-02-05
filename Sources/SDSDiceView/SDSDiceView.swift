//
//  SDSDiceView.swift
//
//  Created by : Tomoaki Yagishita on 2021/02/05
//  © 2021  SmallDeskSoftware
//

import SwiftUI
import Combine

public struct SDSDiceView: View {
    @Binding var dice:Int
    let publisher:AnyPublisher<Void,Never>
    @State private var animate = false
    
    public init(_ dice:Binding<Int>, _ requester:AnyPublisher<Void,Never>) {
        self._dice = dice
        self.publisher = requester
    }
    
    public var body: some View {
        VStack {
            Image("\(dice)")
                .resizable()
                .scaledToFit()
                .rotation3DEffect(
                    Angle.degrees(animate ? 360 * 20 : 0),
                    axis: (x:1, y:1, z:1))
        }
        .onReceive(publisher) { () in
            self.roll()
        }
    }
    public func roll() {
        withAnimation(Animation.default.repeatForever()) {
            animate.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.dice = Int.random(in: 1...6)
                animate.toggle()
            }
        }
        return
    }
}

struct SDSDiceView_Previews: PreviewProvider {
    static var previews: some View {
        SDSDiceView(.constant(3), PassthroughSubject<Void,Never>().eraseToAnyPublisher())
    }
}
