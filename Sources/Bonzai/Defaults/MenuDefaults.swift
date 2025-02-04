import SwiftUI

public struct MenuDefaults {
  public var backgroundColor: Color
  public var calm: Bool
  public var color: Color
  public var cornerRadius: CGFloat
  public var focusEffect: Bool
  public var font: Font
  public var foregroundColor: Color
  public var glow: Bool
  public var grayscaleEffect: Bool
  public var hoverEffect: Bool
  public var padding: MenuDefaults.Padding
  public var unfocusedOpacity: Double

  init(backgroundColor: Color,
       calm: Bool,
       color: Color,
       cornerRadius: CGFloat,
       focusEffect: Bool,
       font: Font,
       foregroundColor: Color,
       glow: Bool,
       grayscaleEffect: Bool,
       hoverEffect: Bool,
       padding: MenuDefaults.Padding,
       unfocusedOpacity: Double) {
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
    self.unfocusedOpacity = unfocusedOpacity
  }

  static func defaults() -> MenuDefaults {
    MenuDefaults(
      backgroundColor: Color.gray,
      calm: false,
      color: Color.gray,
      cornerRadius: 4,
      focusEffect: false,
      font: .body,
      foregroundColor: Color.primary,
      glow: false,
      grayscaleEffect: false,
      hoverEffect: true,
      padding: .medium,
      unfocusedOpacity: 0.1)
  }

   func buttonConfig() -> ButtonDefaults {
     let buttonPadding: ButtonDefaults.Padding = switch padding {
     case .extraLarge: .extraLarge
     case .large: .large
     case .medium: .medium
     case .small: .small
     case .mini: .mini
     }

    return ButtonDefaults(
      backgroundColor: backgroundColor,
      calm: calm,
      cornerRadius: cornerRadius,
      focusEffect: focusEffect,
      font: font,
      foregroundColor: foregroundColor,
      glow: glow,
      grayscaleEffect: grayscaleEffect,
      hoverEffect: hoverEffect,
      padding: buttonPadding,
      unfocusedOpacity: unfocusedOpacity)
  }

  public enum Padding {
    static var extraLargeValue: CGFloat = 16
    static var largeValue: CGFloat = 12
    static var mediumValue: CGFloat = 8
    static var smallValue: CGFloat = 4
    static var miniValue: CGFloat = 2

    case extraLarge
    case large
    case medium
    case small
    case mini

    var edgeInsets: EdgeInsets {
      switch self {
      case .extraLarge:
        EdgeInsets(top: Self.largeValue,
                   leading: Self.extraLargeValue,
                   bottom: Self.largeValue,
                   trailing: Self.extraLargeValue)
      case .large:
        EdgeInsets(top: Self.mediumValue,
                   leading: Self.largeValue,
                   bottom: Self.mediumValue,
                   trailing: Self.largeValue)
      case .medium:
        EdgeInsets(top: Self.smallValue,
                   leading: Self.mediumValue,
                   bottom: Self.smallValue,
                   trailing: Self.mediumValue)
      case .small:
        EdgeInsets(top: Self.miniValue,
                   leading: Self.smallValue,
                   bottom: Self.miniValue,
                   trailing: Self.smallValue)
      case .mini:
        EdgeInsets(top: Self.miniValue,
                   leading: Self.miniValue,
                   bottom: Self.miniValue,
                   trailing: Self.miniValue)

      }
    }
  }
}

public struct MenuOverrides {
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
  public var padding: MenuDefaults.Padding?
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
    padding: MenuDefaults.Padding? = nil,
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
    self.unfocusedOpacity = unfocusedOpacity
  }
}
