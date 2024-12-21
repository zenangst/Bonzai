import SwiftUI

public struct ZenSelectionList<Content: View, Selection: Hashable>: View {
  @Binding private var selection: Selection
  private let content: () -> Content

  public init(_ selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content) {
    _selection = selection
    self.content = content
  }

  public var body: some View {
    List(selection: $selection) {
      content()
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
    .scrollContentBackground(.hidden)
    .listStyle(.plain)
  }
}


