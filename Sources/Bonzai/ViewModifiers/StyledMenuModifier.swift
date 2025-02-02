import SwiftUI

struct StyledMenuModifier: ViewModifier {
  @Environment(\.menuBackgroundColor) var backgroundColor
  @Environment(\.menuCalm) var calm
  @Environment(\.menuCornerRadius) var cornerRadius
  @Environment(\.menuFocusEffect) var focusEffect
  @Environment(\.menuFont) var font
  @Environment(\.menuForegroundColor) var foregroundColor
  @Environment(\.menuGlow) var glow
  @Environment(\.menuGrayscaleEffect) var grayscaleEffect
  @Environment(\.menuHoverEffect) var hoverEffect
  @Environment(\.menuPadding) var padding
  @Environment(\.menuUnfocusedOpacity) var unfocusedOpacity

  private let overrideMenuBackgroundColor: Color?
  private let overrideMenuCalm: Bool?
  private let overrideMenuCornerRadius: CGFloat?
  private let overrideMenuFocusEffect: Bool?
  private let overrideMenuFont: Font?
  private let overrideMenuForegroundColor: Color?
  private let overrideMenuGlow: Bool?
  private let overrideMenuGrayscaleEffect: Bool?
  private let overrideMenuHoverEffect: Bool?
  private let overrideMenuPadding: MenuDefaults.Padding?
  private let overrideMenuUnfocusedOpacity: Double?

  init(backgroundColor overrideMenuBackgroundColor: Color? = nil,
       calm overrideMenuCalm: Bool? = nil,
       cornerRadius overrideMenuCornerRadius: CGFloat? = nil,
       focusEffect overrideMenuFocusEffect: Bool? = nil,
       font overrideMenuFont: Font? = nil,
       foregroundColor overrideMenuForegroundColor: Color? = nil,
       glow overrideMenuGlow: Bool? = nil,
       grayscaleEffect overrideMenuGrayscaleEffect: Bool? = nil,
       hoverEffect overrideMenuHoverEffect: Bool? = nil,
       padding overrideMenuPadding: MenuDefaults.Padding? = nil,
       unfocusedOpacity overrideMenuUnfocusedOpacity: Double? = nil) {
    self.overrideMenuBackgroundColor = overrideMenuBackgroundColor
    self.overrideMenuCalm = overrideMenuCalm
    self.overrideMenuCornerRadius = overrideMenuCornerRadius
    self.overrideMenuFocusEffect = overrideMenuFocusEffect
    self.overrideMenuFont = overrideMenuFont
    self.overrideMenuForegroundColor = overrideMenuForegroundColor
    self.overrideMenuGlow = overrideMenuGlow
    self.overrideMenuGrayscaleEffect = overrideMenuGrayscaleEffect
    self.overrideMenuHoverEffect = overrideMenuHoverEffect
    self.overrideMenuPadding = overrideMenuPadding
    self.overrideMenuUnfocusedOpacity = overrideMenuUnfocusedOpacity
  }

  func body(content: Content) -> some View {
    let config = MenuDefaults(
      backgroundColor: overrideMenuBackgroundColor ?? backgroundColor,
      calm: overrideMenuCalm ?? calm,
      color: overrideMenuForegroundColor ?? foregroundColor,
      cornerRadius: overrideMenuCornerRadius ?? cornerRadius,
      focusEffect: overrideMenuFocusEffect ?? focusEffect,
      font: overrideMenuFont ?? font,
      foregroundColor: overrideMenuForegroundColor ?? foregroundColor,
      glow: overrideMenuGlow ?? glow,
      grayscaleEffect: overrideMenuGrayscaleEffect ?? grayscaleEffect,
      hoverEffect: overrideMenuHoverEffect ?? hoverEffect,
      padding: overrideMenuPadding ?? padding,
      unfocusedOpacity: overrideMenuUnfocusedOpacity ?? unfocusedOpacity
    )

    content
      .menuStyle(ZenMenuStyle(config))
  }
}

public extension View {
  func menuStyle() -> some View {
    self.modifier(StyledMenuModifier(calm: false))
  }

  func menuStyle(_ style: (_ menu: inout MenuOverrides) -> Void) -> some View {
    var overrides = MenuOverrides()
    style(&overrides)
    return self.modifier(
      StyledMenuModifier(
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
