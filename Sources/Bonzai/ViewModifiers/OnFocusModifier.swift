import SwiftUI

public struct OnFocusModifier: ViewModifier {
  @Environment(\.isFocused) var isFocused

  private let focusChange: (Bool) -> Void

  public init(_ focusChange: @escaping (Bool) -> Void) {
    self.focusChange = focusChange
  }

  public func body(content: Content) -> some View {
    content
      .onChange(of: isFocused, perform: { value in
        focusChange(value)
      })
  }
}

public extension View {
  func onFocus(_ focusChange: @escaping () -> Void) -> some View {
    modifier(OnFocusModifier({
      guard $0 else { return }
      focusChange()
    }))
  }

  func onFocusChange(_ focusChange: @escaping (Bool) -> Void) -> some View {
    modifier(OnFocusModifier(focusChange))
  }
}
