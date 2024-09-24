import SwiftUI

public struct ZenList<Content: View>: View {
  private let content: () -> Content

  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }

  public var body: some View {
    List {
      content()
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
    .scrollContentBackground(.hidden)
    .listStyle(.plain)
  }
}
