import Foundation
import SwiftUI

public protocol ViewRouterBuilder {
    associatedtype RouterView: View
    associatedtype State: ViewState
    
    init()
    func build(state: State) -> Self.RouterView
    func animation(to: State, from: State) -> Animation?
    func transition(to: State, from: State) -> AnyTransition
}

public extension ViewRouterBuilder {
    func animation(to: State, from: State) -> Animation? {
        .default
    }
    
    func transition(to: State, from: State) -> AnyTransition {
        .identity
    }
}

public protocol ViewState { }
public protocol ViewRouting {
    associatedtype State: ViewState
    func route(to state: State)
}

public class ViewRouter<Builder>: ViewRouting, ObservableObject where Builder: ViewRouterBuilder {
    public typealias State = Builder.State
    private let initial: State
    
    public init(for builder: Builder.Type, initial state: State) {
        self.builder = Builder()
        self.initial = state
        self.activeState = state
        self.previousState = state
    }
    
    public var activeState: State
    private var previousState: State
    private var builder: Builder
    
    public func refresh() {
        self.activeState = initial
        self.previousState = initial
        withAnimation(builder.animation(to: activeState, from: previousState)) {
            objectWillChange.send()
        }
    }
    
    public func route(to state: State) {
        previousState = activeState
        activeState = state
        withAnimation(builder.animation(to: activeState, from: previousState)) {
            objectWillChange.send()
        }
    }
    
    public var view: some View {
        builder.build(state: activeState)
            .transition(builder.transition(to: activeState, from: previousState))
    }
}
