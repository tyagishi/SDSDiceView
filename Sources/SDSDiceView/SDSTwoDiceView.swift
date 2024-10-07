//
//  SDSTwoDiceView.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/07
//  © 2024  SmallDeskSoftware
//

import SwiftUI
import Combine

public struct SDSTwoDiceView: View {
    let publisher: AnyPublisher<Void,Never>
    let reporter: PassthroughSubject<(Int,Int),Never>?
    @State private var angle = Angle.degrees(0)
    @State private var diceValues: (Int,Int) = (1,1)
    @State private var axis0: (CGFloat, CGFloat, CGFloat) = (1.0, 1.0, 1.0)
    @State private var axis1: (CGFloat, CGFloat, CGFloat) = (1.0, 1.0, 1.0)

    public init(_ requester: AnyPublisher<Void,Never>,
                _ reporter: PassthroughSubject<(Int,Int),Never>? = nil ) {
        self.publisher = requester
        self.reporter = reporter
    }

    public var body: some View {
        HStack {
            Image("\(diceValues.0)", bundle: .module)
                .resizable()
                .scaledToFit()
                .rotation3DEffect(angle,
                                  axis: axis0)
            Image("\(diceValues.1)", bundle: .module)
                .resizable()
                .scaledToFit()
                .rotation3DEffect(angle,
                                  axis: axis1)
        }
        .onReceive(publisher) { () in
            axis0 = randomAxis
            axis1 = randomAxis
            withAnimation(.linear(duration: 0.5)) {
                angle += .degrees(180*5)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 0.5)) {
                    self.diceValues.0 = Int.random(in: 1...6)
                    self.diceValues.1 = Int.random(in: 1...6)
                    angle += .degrees(180*5)
                }
                Task {
                    try? await Task.sleep(for: .seconds(0.5))
                    reporter?.send((diceValues.0, diceValues.1))
                }
            }
        }
    }
    
    var randomAxis: (x: CGFloat, y: CGFloat, z: CGFloat) {
        (Bool.random() ? 1.0 : -1.0, Bool.random() ? 1.0 : -1.0, Bool.random() ? 1.0 : -1.0)
    }
}
