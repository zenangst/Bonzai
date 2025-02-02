import SwiftUI

struct TextFieldModifier: ViewModifier {
  @Environment(\.textFieldBackgroundColor) var backgroundColor
  @Environment(\.textFieldCalm) var calm
  @Environment(\.textFieldCornerRadius) var cornerRadius
  @Environment(\.textFieldDecorationColor) var decorationColor
  @Environment(\.textFieldFocusEffect) var focusEffect
  @Environment(\.textFieldFont) var font
  @Environment(\.textFieldForegroundColor) var foregroundColor
  @Environment(\.textFieldGlow) var glow
  @Environment(\.textFieldGrayscaleEffect) var grayscaleEffect
  @Environment(\.textFieldHoverEffect) var hoverEffect
  @Environment(\.textFieldPadding) var padding
  @Environment(\.textFieldStyle) var style
  @Environment(\.textFieldUnfocusedOpacity) var unfocusedOpacity

  private let overrideTextFieldBackgroundColor: Color?
  private let overrideTextFieldCalm: Bool?
  private let overrideTextFieldCornerRadius: CGFloat?
  private let overrideTextFieldDecorationColor: Color?
  private let overrideTextFieldFocusEffect: Bool?
  private let overrideTextFieldFont: Font?
  private let overrideTextFieldForegroundColor: Color?
  private let overrideTextFieldGlow: Bool?
  private let overrideTextFieldGrayscaleEffect: Bool?
  private let overrideTextFieldHoverEffect: Bool?
  private let overrideTextFieldPadding: TextFieldDefaults.Padding?
  private let overrideTextFieldStyle: TextFieldDefaults.Style?
  private let overrideTextFieldUnfocusedOpacity: Double?

  init(overrideTextFieldBackgroundColor: Color? = nil,
       overrideTextFieldCalm: Bool? = nil,
       overrideTextFieldCornerRadius: CGFloat? = nil,
       overrideTextFieldDecorationColor: Color? = nil,
       overrideTextFieldFocusEffect: Bool? = nil,
       overrideTextFieldFont: Font? = nil,
       overrideTextFieldForegroundColor: Color? = nil,
       overrideTextFieldGlow: Bool? = nil,
       overrideTextFieldGrayscaleEffect: Bool? = nil,
       overrideTextFieldHoverEffect: Bool? = nil,
       overrideTextFieldPadding: TextFieldDefaults.Padding? = nil,
       overrideTextFieldStyle: TextFieldDefaults.Style? = nil,
       overrideTextFieldUnfocusedOpacity: Double? = nil) {
    self.overrideTextFieldBackgroundColor = overrideTextFieldBackgroundColor
    self.overrideTextFieldCalm = overrideTextFieldCalm
    self.overrideTextFieldCornerRadius = overrideTextFieldCornerRadius
    self.overrideTextFieldDecorationColor = overrideTextFieldDecorationColor
    self.overrideTextFieldFocusEffect = overrideTextFieldFocusEffect
    self.overrideTextFieldFont = overrideTextFieldFont
    self.overrideTextFieldForegroundColor = overrideTextFieldForegroundColor
    self.overrideTextFieldGlow = overrideTextFieldGlow
    self.overrideTextFieldGrayscaleEffect = overrideTextFieldGrayscaleEffect
    self.overrideTextFieldHoverEffect = overrideTextFieldHoverEffect
    self.overrideTextFieldPadding = overrideTextFieldPadding
    self.overrideTextFieldStyle = overrideTextFieldStyle
    self.overrideTextFieldUnfocusedOpacity = overrideTextFieldUnfocusedOpacity
  }

  func body(content: Content) -> some View {
    let config = TextFieldDefaults(
      backgroundColor: overrideTextFieldBackgroundColor ?? backgroundColor,
      calm: overrideTextFieldCalm ?? calm,
      color: overrideTextFieldForegroundColor ?? foregroundColor,
      cornerRadius: overrideTextFieldCornerRadius ?? cornerRadius,
      decorationColor: overrideTextFieldDecorationColor ?? decorationColor,
      focusEffect: overrideTextFieldFocusEffect ?? focusEffect,
      font: overrideTextFieldFont ?? font,
      foregroundColor: overrideTextFieldForegroundColor ?? foregroundColor,
      glow: overrideTextFieldGlow ?? glow,
      grayscaleEffect: overrideTextFieldGrayscaleEffect ?? grayscaleEffect,
      hoverEffect: overrideTextFieldHoverEffect ?? hoverEffect,
      padding: overrideTextFieldPadding ?? padding,
      style: overrideTextFieldStyle ?? style,
      unfocusedOpacity: overrideTextFieldUnfocusedOpacity ?? unfocusedOpacity
    )

    content.textFieldStyle(ZenTextFieldStyle(config))
  }
}

public extension View {
  func textFieldStyle() -> some View {
    self.modifier(TextFieldModifier())
  }

  func textFieldStyle(_ style: (_ textField: inout TextFieldOverrides) -> Void) -> some View {
    var config = TextFieldOverrides()
    style(&config)
    return self.modifier(
      TextFieldModifier(
        overrideTextFieldBackgroundColor: config.backgroundColor,
        overrideTextFieldCalm: config.calm,
        overrideTextFieldCornerRadius: config.cornerRadius,
        overrideTextFieldDecorationColor: config.decorationColor,
        overrideTextFieldFocusEffect: config.focusEffect,
        overrideTextFieldFont: config.font,
        overrideTextFieldForegroundColor: config.foregroundColor,
        overrideTextFieldGlow: config.glow,
        overrideTextFieldGrayscaleEffect: config.grayscaleEffect,
        overrideTextFieldHoverEffect: config.hoverEffect,
        overrideTextFieldPadding: config.padding,
        overrideTextFieldStyle: config.style,
        overrideTextFieldUnfocusedOpacity: config.unfocusedOpacity
      )
    )
  }
}
