import SwiftUI

public struct ButtonDefaults {
  public enum Padding {
    static var extraLargeValue: CGFloat = 16
    static var largeValue: CGFloat = 12
    static var mediumValue: CGFloat = 8
    static var smallValue: CGFloat = 4
    static var miniValue: CGFloat = 2
    static var zeroValue: CGFloat = 0

    case extraLarge
    case large
    case medium
    case small
    case mini
    case zero

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
      case .zero:
        EdgeInsets(top: 0,
                   leading: 0,
                   bottom: 0,
                   trailing: 0)

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
  public var padding: ButtonDefaults.Padding
  public var unfocusedOpacity: Double

  init(backgroundColor: Color,
       calm: Bool,
       cornerRadius: CGFloat,
       focusEffect: Bool,
       font: Font,
       foregroundColor: Color,
       glow: Bool,
       grayscaleEffect: Bool,
       hoverEffect: Bool,
       padding: ButtonDefaults.Padding,
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
    self.unfocusedOpacity = unfocusedOpacity
  }

  static func defaults() -> ButtonDefaults {
    ButtonDefaults(
      backgroundColor: Color.accentColor,
      calm: false,
      cornerRadius: 4,
      focusEffect: false,
      font: .body,
      foregroundColor: Color.white,
      glow: false,
      grayscaleEffect: false,
      hoverEffect:  true,
      padding: .small,
      unfocusedOpacity: 0.1
    )
  }
}

public struct ButtonOverrides {
  public var backgroundColor: Color?
  public var calm: Bool?
  public var cornerRadius: CGFloat?
  public var focusEffect: Bool?
  public var font: Font?
  public var foregroundColor: Color?
  public var glow: Bool?
  public var grayscaleEffect: Bool?
  public var hoverEffect: Bool?
  public var padding: ButtonDefaults.Padding?
  public var unfocusedOpacity: Double?

  init(
    backgroundColor: Color? = nil,
    calm: Bool? = nil,
    cornerRadius: CGFloat? = nil,
    focusEffect: Bool? = nil,
    font: Font? = nil,
    foregroundColor: Color? = nil,
    glow: Bool? = nil,
    grayscaleEffect: Bool? = nil,
    hoverEffect: Bool? = nil,
    padding: ButtonDefaults.Padding? = nil,
    unfocusedOpacity: Double? = nil
  ) {
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
    self.unfocusedOpacity = unfocusedOpacity
  }
}
