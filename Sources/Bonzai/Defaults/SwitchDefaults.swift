import SwiftUI

public struct SwitchDefaults {
  public enum Style {
    case regular
    case medium
    case small

    var size: CGSize {
      switch self {
      case .regular: CGSize(width: 38, height: 20)
      case .medium: CGSize(width: 34, height: 17)
      case .small:   CGSize(width: 28, height: 14)
      }
    }
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

  public var backgroundColor: Color
  public var calm: Bool
  public var cornerRadius: CGFloat
  public var focusEffect: Bool
  public var font: Font
  public var foregroundColor: Color
  public var glow: Bool
  public var grayscaleEffect: Bool
  public var hoverEffect: Bool
  public var padding: SwitchDefaults.Padding
  public var unfocusedOpacity: Double
  public var style: Style

  init(backgroundColor: Color,
       calm: Bool,
       cornerRadius: CGFloat,
       focusEffect: Bool,
       font: Font,
       foregroundColor: Color,
       glow: Bool,
       grayscaleEffect: Bool,
       hoverEffect: Bool,
       padding: SwitchDefaults.Padding,
       style: Style,
       unfocusedOpacity: Double) {
    self.backgroundColor = backgroundColor
    self.calm = calm
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

  static func defaults() -> SwitchDefaults {
    SwitchDefaults(
      backgroundColor: Color.systemGreen,
      calm: false,
      cornerRadius: 4,
      focusEffect: false,
      font: .body,
      foregroundColor: Color.white,
      glow: false,
      grayscaleEffect: false,
      hoverEffect: true,
      padding: .small,
      style: .medium,
      unfocusedOpacity: 0.1)
  }
}
