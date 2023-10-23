import SwiftUI

public struct ViewRoot<RootView>: View where RootView: ViewRouterBuilder {
    @StateObject var router: ViewRouter<RootView>
    public var body: some View {
        router.view.id(UUID().uuidString)
    }
    
    public init(router: ViewRouter<RootView>) {
        _router = StateObject(wrappedValue: router)
    }
}
