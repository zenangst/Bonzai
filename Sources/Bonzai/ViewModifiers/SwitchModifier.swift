import SwiftUI

struct SwitchModifier: ViewModifier {
  @Environment(\.switchBackgroundColor) var backgroundColor
  @Environment(\.switchCalm) var calm
  @Environment(\.switchCornerRadius) var cornerRadius
  @Environment(\.switchFocusEffect) var focusEffect
  @Environment(\.switchFont) var font
  @Environment(\.switchForegroundColor) var foregroundColor
  @Environment(\.switchGlow) var glow
  @Environment(\.switchGrayscaleEffect) var grayscaleEffect
  @Environment(\.switchHoverEffect) var hoverEffect
  @Environment(\.switchPadding) var padding
  @Environment(\.switchStyle) var style
  @Environment(\.switchUnfocusedOpacity) var unfocusedOpacity

  private let overrideSwitchBackgroundColor: Color?
  private let overrideSwitchCalm: Bool?
  private let overrideSwitchCornerRadius: CGFloat?
  private let overrideSwitchFocusEffect: Bool?
  private let overrideSwitchFont: Font?
  private let overrideSwitchForegroundColor: Color?
  private let overrideSwitchGlow: Bool?
  private let overrideSwitchGrayscaleEffect: Bool?
  private let overrideSwitchHoverEffect: Bool?
  private let overrideSwitchPadding: SwitchDefaults.Padding?
  private let overrideSwitchStyle: SwitchDefaults.Style?
  private let overrideSwitchUnfocusedOpacity: Double?

  init(overrideSwitchBackgroundColor: Color? = nil,
       overrideSwitchCalm: Bool? = nil,
       overrideSwitchCornerRadius: CGFloat? = nil,
       overrideSwitchFocusEffect: Bool? = nil,
       overrideSwitchFont: Font? = nil,
       overrideSwitchForegroundColor: Color? = nil,
       overrideSwitchGlow: Bool? = nil,
       overrideSwitchGrayscaleEffect: Bool? = nil,
       overrideSwitchHoverEffect: Bool? = nil,
       overrideSwitchPadding: SwitchDefaults.Padding? = nil,
       overrideSwitchStyle: SwitchDefaults.Style? = nil,
       overrideSwitchUnfocusedOpacity: Double? = nil) {
    self.overrideSwitchBackgroundColor = overrideSwitchBackgroundColor
    self.overrideSwitchCalm = overrideSwitchCalm
    self.overrideSwitchCornerRadius = overrideSwitchCornerRadius
    self.overrideSwitchFocusEffect = overrideSwitchFocusEffect
    self.overrideSwitchFont = overrideSwitchFont
    self.overrideSwitchForegroundColor = overrideSwitchForegroundColor
    self.overrideSwitchGlow = overrideSwitchGlow
    self.overrideSwitchGrayscaleEffect = overrideSwitchGrayscaleEffect
    self.overrideSwitchHoverEffect = overrideSwitchHoverEffect
    self.overrideSwitchPadding = overrideSwitchPadding
    self.overrideSwitchStyle = overrideSwitchStyle
    self.overrideSwitchUnfocusedOpacity = overrideSwitchUnfocusedOpacity
  }


  func body(content: Content) -> some View {
    content
      .toggleStyle(ZenSwitchStyle(style: overrideSwitchStyle ?? style))
      .environment(\.switchForegroundColor, overrideSwitchForegroundColor ?? foregroundColor)
      .environment(\.switchBackgroundColor, overrideSwitchBackgroundColor ?? backgroundColor)
      .environment(\.switchStyle, style)
  }
}

public extension View {
  func switchStyle() -> some View {
    self.modifier(SwitchModifier())
  }

  func switchStyle(_ manipulate: (inout SwitchOverrides) -> Void) -> some View {
    var config = SwitchOverrides()
    manipulate(&config)
    return self.modifier(
      SwitchModifier(
        overrideSwitchBackgroundColor: config.backgroundColor,
        overrideSwitchCalm: config.calm,
        overrideSwitchCornerRadius: config.cornerRadius,
        overrideSwitchFocusEffect: config.focusEffect,
        overrideSwitchFont: config.font,
        overrideSwitchForegroundColor: config.foregroundColor,
        overrideSwitchGlow: config.glow,
        overrideSwitchGrayscaleEffect: config.grayscaleEffect,
        overrideSwitchHoverEffect: config.hoverEffect,
        overrideSwitchPadding: config.padding,
        overrideSwitchStyle: config.style,
        overrideSwitchUnfocusedOpacity: config.unfocusedOpacity
      )
    )
  }
}

public struct SwitchOverrides {
  public var backgroundColor: Color?
  public var calm: Bool?
  public var color: Color?
  public var cornerRadius: CGFloat?
  public var focusEffect: Bool?
  public var font: Font?
  public var foregroundColor: Color?
  public var glow: Bool?
  public var grayscaleEffect: Bool?
  public var hoverEffect: Bool?
  public var padding: SwitchDefaults.Padding?
  public var style: SwitchDefaults.Style?
  public var unfocusedOpacity: Double?

  init(
    backgroundColor: Color? = nil,
    calm: Bool? = nil,
    color: Color? = nil,
    cornerRadius: CGFloat? = nil,
    focusEffect: Bool? = nil,
    font: Font? = nil,
    foregroundColor: Color? = nil,
    glow: Bool? = nil,
    grayscaleEffect: Bool? = nil,
    hoverEffect: Bool? = nil,
    padding: SwitchDefaults.Padding? = nil,
    style: SwitchDefaults.Style? = nil,
    unfocusedOpacity: Double? = nil
  ) {
    self.backgroundColor = backgroundColor
    self.calm = calm
    self.color = color
    self.cornerRadius = cornerRadius
    self.focusEffect = focusEffect
    self.font = font
    self.foregroundColor = foregroundColor
    self.glow = glow
    self.grayscaleEffect = grayscaleEffect
    self.hoverEffect = hoverEffect
    self.padding = padding
    self.style = style
    self.unfocusedOpacity = unfocusedOpacity
  }
}
