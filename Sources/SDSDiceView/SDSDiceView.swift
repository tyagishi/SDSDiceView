//
//  SDSDiceView.swift
//
//  Created by : Tomoaki Yagishita on 2021/02/05
//  © 2021  SmallDeskSoftware
//

import SwiftUI
import Combine

public struct SDSDiceView: View {
    @Binding var dice: Int
    let publisher: AnyPublisher<Void,Never>
    @State private var angle = Angle.degrees(0)

    public init(_ dice: Binding<Int>, _ requester: AnyPublisher<Void,Never>) {
        self._dice = dice
        self.publisher = requester
    }
    
    public var body: some View {
        VStack {
            Image("\(dice)", bundle: .module)
                .resizable()
                .scaledToFit()
                .rotation3DEffect(angle,
                                  axis: (x: 1, y: 1, z: 1))
        }
        .onReceive(publisher) { () in
            withAnimation(.linear(duration: 0.5)) {
                angle += .degrees(180*5)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 0.5)) {
                    self.dice = Int.random(in: 1...6)
                    angle += .degrees(180*5)
                }
            }
        }
    }
}

struct SDSDiceView_Previews: PreviewProvider {
    static var previews: some View {
        SDSDiceView(.constant(3), PassthroughSubject<Void,Never>().eraseToAnyPublisher())
    }
}
