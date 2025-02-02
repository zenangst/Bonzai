import SwiftUI

struct CheckboxModifier: ViewModifier {
  @Environment(\.toggleBackgroundColor) var backgroundColor
  @Environment(\.toggleCalm) var calm
  @Environment(\.toggleCornerRadius) var cornerRadius
  @Environment(\.toggleFocusEffect) var focusEffect
  @Environment(\.toggleFont) var font
  @Environment(\.toggleForegroundColor) var foregroundColor
  @Environment(\.toggleGlow) var glow
  @Environment(\.toggleGrayscaleEffect) var grayscaleEffect
  @Environment(\.toggleHoverEffect) var hoverEffect
  @Environment(\.togglePadding) var padding
  @Environment(\.toggleStyle) var style
  @Environment(\.toggleUnfocusedOpacity) var unfocusedOpacity

  private let overrideToggleBackgroundColor: Color?
  private let overrideToggleCalm: Bool?
  private let overrideToggleCornerRadius: CGFloat?
  private let overrideToggleFocusEffect: Bool?
  private let overrideToggleFont: Font?
  private let overrideToggleForegroundColor: Color?
  private let overrideToggleGlow: Bool?
  private let overrideToggleGrayscaleEffect: Bool?
  private let overrideToggleHoverEffect: Bool?
  private let overrideTogglePadding: ToggleDefaults.Padding?
  private let overrideToggleStyle: ToggleDefaults.Style?
  private let overrideToggleUnfocusedOpacity: Double?

  init(overrideToggleBackgroundColor: Color? = nil,
       overrideToggleCalm: Bool? = nil,
       overrideToggleCornerRadius: CGFloat? = nil,
       overrideToggleFocusEffect: Bool? = nil,
       overrideToggleFont: Font? = nil,
       overrideToggleForegroundColor: Color? = nil,
       overrideToggleGlow: Bool? = nil,
       overrideToggleGrayscaleEffect: Bool? = nil,
       overrideToggleHoverEffect: Bool? = nil,
       overrideTogglePadding: ToggleDefaults.Padding? = nil,
       overrideToggleStyle: ToggleDefaults.Style? = nil,
       overrideToggleUnfocusedOpacity: Double? = nil) {
    self.overrideToggleBackgroundColor = overrideToggleBackgroundColor
    self.overrideToggleCalm = overrideToggleCalm
    self.overrideToggleCornerRadius = overrideToggleCornerRadius
    self.overrideToggleFocusEffect = overrideToggleFocusEffect
    self.overrideToggleFont = overrideToggleFont
    self.overrideToggleForegroundColor = overrideToggleForegroundColor
    self.overrideToggleGlow = overrideToggleGlow
    self.overrideToggleGrayscaleEffect = overrideToggleGrayscaleEffect
    self.overrideToggleHoverEffect = overrideToggleHoverEffect
    self.overrideTogglePadding = overrideTogglePadding
    self.overrideToggleStyle = overrideToggleStyle
    self.overrideToggleUnfocusedOpacity = overrideToggleUnfocusedOpacity
  }

  func body(content: Content) -> some View {

    let config = ToggleDefaults.init(
      backgroundColor: overrideToggleBackgroundColor ?? backgroundColor,
      calm: overrideToggleCalm ?? calm,
      cornerRadius: overrideToggleCornerRadius ?? cornerRadius,
      focusEffect: overrideToggleFocusEffect ?? focusEffect,
      font: overrideToggleFont ?? font,
      foregroundColor: overrideToggleForegroundColor ?? foregroundColor,
      glow: overrideToggleGlow ?? glow,
      grayscaleEffect: overrideToggleGrayscaleEffect ?? grayscaleEffect,
      hoverEffect: overrideToggleHoverEffect ?? hoverEffect,
      padding: overrideTogglePadding ?? padding,
      style: overrideToggleStyle ?? style,
      unfocusedOpacity: overrideToggleUnfocusedOpacity ?? unfocusedOpacity
    )

    content
      .toggleStyle(ZenCheckboxStyle(config: config))
      .environment(\.toggleStyle, overrideToggleStyle ?? .regular)
  }
}

public extension View {
  func checkboxStyle() -> some View {
    self.modifier(CheckboxModifier())
  }

  func checkboxStyle(_ manipulate: (_ checkbox: inout ToggleOverrides) -> Void) -> some View {
    var config = ToggleOverrides()
    manipulate(&config)
    return self.modifier(
      CheckboxModifier(
        overrideToggleBackgroundColor: config.backgroundColor,
        overrideToggleCalm: config.calm,
        overrideToggleCornerRadius: config.cornerRadius,
        overrideToggleFocusEffect: config.focusEffect,
        overrideToggleFont: config.font,
        overrideToggleForegroundColor: config.foregroundColor,
        overrideToggleGlow: config.glow,
        overrideToggleGrayscaleEffect: config.grayscaleEffect,
        overrideToggleHoverEffect: config.hoverEffect,
        overrideTogglePadding: config.padding,
        overrideToggleStyle: config.style,
        overrideToggleUnfocusedOpacity: config.unfocusedOpacity
      )
    )
  }
}
