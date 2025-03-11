import SwiftUI

struct ButtonModifier: ViewModifier {
  @Environment(\.buttonBackgroundColor) var backgroundColor
  @Environment(\.buttonCalm) var calm
  @Environment(\.buttonCornerRadius) var cornerRadius
  @Environment(\.buttonFocusEffect) var focusEffect
  @Environment(\.buttonFont) var font
  @Environment(\.buttonForegroundColor) var foregroundColor
  @Environment(\.buttonGlow) var glow
  @Environment(\.buttonGrayscaleEffect) var grayscaleEffect
  @Environment(\.buttonHoverEffect) var hoverEffect
  @Environment(\.buttonPadding) var padding
  @Environment(\.buttonUnfocusedOpacity) var unfocusedOpacity

  private let overrideButtonBackgroundColor: Color?
  private let overrideButtonCalm: Bool?
  private let overrideButtonCornerRadius: CGFloat?
  private let overrideButtonFocusEffect: Bool?
  private let overrideButtonFont: Font?
  private let overrideButtonForegroundColor: Color?
  private let overrideButtonGlow: Bool?
  private let overrideButtonGrayscaleEffect: Bool?
  private let overrideButtonHoverEffect: Bool?
  private let overrideButtonPadding: ButtonDefaults.Padding?
  private let overrideButtonUnfocusedOpacity: Double?

  init(backgroundColor overrideButtonBackgroundColor: Color? = nil,
       calm overrideButtonCalm: Bool? = nil,
       cornerRadius overrideButtonCornerRadius: CGFloat? = nil,
       focusEffect overrideButtonFocusEffect: Bool? = nil,
       font overrideButtonFont: Font? = nil,
       foregroundColor overrideButtonForegroundColor: Color? = nil,
       glow overrideButtonGlow: Bool? = nil,
       grayscaleEffect overrideButtonGrayscaleEffect: Bool? = nil,
       hoverEffect overrideButtonHoverEffect: Bool? = nil,
       padding overrideButtonPadding: ButtonDefaults.Padding? = nil,
       unfocusedOpacity overrideButtonUnfocusedOpacity: Double? = nil) {
    self.overrideButtonBackgroundColor = overrideButtonBackgroundColor
    self.overrideButtonCalm = overrideButtonCalm
    self.overrideButtonCornerRadius = overrideButtonCornerRadius
    self.overrideButtonFocusEffect = overrideButtonFocusEffect
    self.overrideButtonFont = overrideButtonFont
    self.overrideButtonForegroundColor = overrideButtonForegroundColor
    self.overrideButtonGlow = overrideButtonGlow
    self.overrideButtonGrayscaleEffect = overrideButtonGrayscaleEffect
    self.overrideButtonHoverEffect = overrideButtonHoverEffect
    self.overrideButtonPadding = overrideButtonPadding
    self.overrideButtonUnfocusedOpacity = overrideButtonUnfocusedOpacity
  }


  func body(content: Content) -> some View {
    content.buttonStyle(ZenButtonStyle())
      .environment(\.buttonBackgroundColor, overrideButtonBackgroundColor ?? backgroundColor)
      .environment(\.buttonForegroundColor, overrideButtonForegroundColor ?? foregroundColor)
      .environment(\.buttonCalm, overrideButtonCalm ?? calm)
      .environment(\.buttonCornerRadius, overrideButtonCornerRadius ?? cornerRadius)
      .environment(\.buttonFocusEffect, overrideButtonFocusEffect ?? focusEffect)
      .environment(\.buttonFont, overrideButtonFont ?? font)
      .environment(\.buttonGlow, overrideButtonGlow ?? glow)
      .environment(\.buttonGrayscaleEffect, overrideButtonGrayscaleEffect ?? grayscaleEffect)
      .environment(\.buttonHoverEffect, overrideButtonHoverEffect ?? hoverEffect)
      .environment(\.buttonPadding, overrideButtonPadding ?? padding)
      .environment(\.buttonUnfocusedOpacity, overrideButtonUnfocusedOpacity ?? unfocusedOpacity)
  }
}

public enum PredefinedButtonStyle {
  case cancel
  case positive
  case destructive
  case help
}

public extension View {
  @ViewBuilder
  func buttonStyle() -> some View {
    self.modifier(ButtonModifier())
  }

  @ViewBuilder
  func buttonStyle(_ style: PredefinedButtonStyle) -> some View {
    switch style {
    case .positive:
      self.modifier(ButtonModifier(
        backgroundColor: .systemGreen,
        hoverEffect: false
      ))
    case .cancel:
      self.modifier(
        ButtonModifier(
          backgroundColor: .systemGray,
          calm: true,
          grayscaleEffect: true
        )
      )
    case .help:
      self.modifier(ButtonModifier(
        backgroundColor: .systemYellow,
        calm: true,
        hoverEffect: true
      ))
    case .destructive:
      self.modifier(
        ButtonModifier(
          backgroundColor: .systemRed,
          grayscaleEffect: true,
          padding: .medium
        )
      )
    }
  }

  func buttonStyle(_ style: (_ button: inout ButtonOverrides) -> Void) -> some View {
    var overrides = ButtonOverrides()
    style(&overrides)
    return self.modifier(
      ButtonModifier(
        backgroundColor: overrides.backgroundColor,
        calm: overrides.calm,
        cornerRadius: overrides.cornerRadius,
        focusEffect: overrides.focusEffect,
        font: overrides.font,
        foregroundColor: overrides.foregroundColor,
        glow: overrides.glow,
        grayscaleEffect: overrides.grayscaleEffect,
        hoverEffect: overrides.hoverEffect,
        padding: overrides.padding,
        unfocusedOpacity: overrides.unfocusedOpacity
      )
    )
  }
}
