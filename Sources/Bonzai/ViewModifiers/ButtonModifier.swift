import SwiftUI

struct ButtonModifier: ViewModifier {
  @Environment(\.buttonHoverEffect) var hoverEffect

  func body(content: Content) -> some View {
    content.buttonStyle(ZenButtonStyle(hoverEffect: hoverEffect))
  }
}

public enum PredefinedButtonStyle {
  case cancel
  case positive
  case destructive
  case help
}

extension View {
  @ViewBuilder
  func buttonStyle() -> some View {
    self.modifier(ButtonModifier())
  }

  @ViewBuilder
  public func buttonStyle(_ style: PredefinedButtonStyle) -> some View {
    switch style {
    case .positive:
      self.modifier(ButtonModifier())
        .environment(\.buttonBackgroundColor, .systemGreen)
        .environment(\.buttonHoverEffect, false)
    case .cancel:
      self.modifier(ButtonModifier())
        .environment(\.buttonCalm, true)
        .environment(\.buttonBackgroundColor, .systemGray)
        .environment(\.buttonGrayscaleEffect, true)
    case .help:
      self.modifier(ButtonModifier())
      .environment(\.buttonCalm, true)
      .environment(\.buttonBackgroundColor, .systemYellow)
      .environment(\.buttonGrayscaleEffect, true)
    case .destructive:
      self.modifier(ButtonModifier())
        .environment(\.buttonPadding, .medium)
        .environment(\.buttonBackgroundColor, .systemRed)
        .environment(\.buttonGrayscaleEffect, true)
    }
  }
}
