//
//  SDSDiceView.swift
//
//  Created by : Tomoaki Yagishita on 2021/02/05
//  © 2021  SmallDeskSoftware
//

import SwiftUI
import Combine

enum DicePhase: CaseIterable {
    case firstHalf
    case secondHalf
}

public struct SDSDiceView: View {
    @Binding var dice: Int
    let publisher: AnyPublisher<Void,Never>
    @State private var animate = false
    
    public init(_ dice: Binding<Int>, _ requester: AnyPublisher<Void,Never>) {
        self._dice = dice
        self.publisher = requester
    }
    
    public var body: some View {
        VStack {
            Image("\(dice)", bundle: .module)
                .resizable()
                .scaledToFit()
                .transition(RotatingFadeTransition())
        }
        .animation(.default, value: dice)
        .phaseAnimator(DicePhase.allCases, content: { view, _ in
            view
        })
        .onReceive(publisher) { () in
            self.roll()
        }
    }
    public func roll() {
        self.dice = Int.random(in: 1...6)
        return
    }
}

struct RotatingFadeTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
          .opacity(phase.isIdentity ? 1.0 : 0.0)
          .rotationEffect(phase.rotation)
    }
}

extension TransitionPhase {
    fileprivate var rotation: Angle {
        switch self {
        case .willAppear: return .degrees(30)
        case .identity: return .zero
        case .didDisappear: return .degrees(-30)
        }
    }
}

struct SDSDiceView_Previews: PreviewProvider {
    static var previews: some View {
        SDSDiceView(.constant(3), PassthroughSubject<Void,Never>().eraseToAnyPublisher())
    }
}
