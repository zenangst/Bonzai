import SwiftUI

public extension View {
  @ViewBuilder
  func focusable<T>(_ focus: FocusState<T?>.Binding, as value: T, onFocus: @escaping () -> Void) -> some View {
    ZStack {
      self
        .onFocus(onFocus)
    }
    .focusable(true)
    .focused(focus, equals: value)
    .focusEffectDisabled_shim()
  }

  @ViewBuilder
  func focusEffectDisabled_shim() -> some View {
    if #available(macOS 14.0, *) {
      self.focusEffectDisabled()
    } else {
      self
    }
  }
}
