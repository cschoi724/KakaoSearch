import SwiftUI
import ComposableArchitecture
import Presentation

@main
struct KakaoSearchApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}

struct AppRootView: View {
    private let env = AppDependency.shared.makeSearchEnv()

    var body: some View {
        NavigationStack {
            SearchRootView(
                store: Store(
                    initialState: SearchFeature.State(),
                    reducer: { SearchFeature(env: env) }
                )
            )
        }
    }
}
