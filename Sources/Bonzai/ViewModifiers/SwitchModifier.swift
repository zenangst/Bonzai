import SwiftUI

struct SwitchModifier: ViewModifier {
  private let overrideSwitchStyle: SwitchDefaults.Style?

  init(overrideSwitchStyle: SwitchDefaults.Style? = nil) {
    self.overrideSwitchStyle = overrideSwitchStyle
  }

  func body(content: Content) -> some View {
    content
      .toggleStyle(ZenSwitchStyle(style: overrideSwitchStyle ?? SwitchDefaults.defaults().style))
  }
}

public extension View {
  func switchStyle(_ style: SwitchDefaults.Style? = nil) -> some View {
    self.modifier(SwitchModifier(overrideSwitchStyle: style))
  }
}
