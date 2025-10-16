import SwiftUI

public struct RootBootstrapView: View {
  public init() {}
  public var body: some View {
    NavigationStack {
      Text("Hello, KakaoSearch")
        .padding()
        .navigationTitle("Kakao Search")
    }
  }
}
