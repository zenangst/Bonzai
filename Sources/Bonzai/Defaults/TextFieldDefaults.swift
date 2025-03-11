import SwiftUI

public struct TextFieldDefaults {
  public enum Style {
    case automatic
    case plain
    case roundedBorder
    case squareBorder

    var textStyle: any TextFieldStyle {
      switch self {
      case .automatic: .automatic
      case .plain: .plain
      case .roundedBorder: .roundedBorder
      case .squareBorder: .squareBorder
      }
    }
  }

  public var backgroundColor: Color
  public var calm: Bool
  public var color: Color
  public var cornerRadius: CGFloat
  public var decorationColor: Color
  public var focusEffect: Bool
  public var font: Font
  public var foregroundColor: Color
  public var glow: Bool
  public var grayscaleEffect: Bool
  public var hoverEffect: Bool
  public var padding: TextFieldDefaults.Padding
  public var style: Style
  public var unfocusedOpacity: Double

  init(backgroundColor: Color,
       calm: Bool,
       color: Color,
       cornerRadius: CGFloat,
       decorationColor: Color,
       focusEffect: Bool,
       font: Font,
       foregroundColor: Color,
       glow: Bool,
       grayscaleEffect: Bool,
       hoverEffect: Bool,
       padding: Padding,
       style: Style,
       unfocusedOpacity: Double) {
    self.backgroundColor = backgroundColor
    self.calm = calm
    self.color = color
    self.cornerRadius = cornerRadius
    self.decorationColor = decorationColor
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

  static func defaults() -> TextFieldDefaults {
    TextFieldDefaults(backgroundColor: Color.clear,
     calm: false,
     color: .accentColor,
     cornerRadius: 4,
     decorationColor: .accentColor,
     focusEffect: false,
     font: .body,
     foregroundColor: Color.primary,
     glow: false,
     grayscaleEffect: false,
     hoverEffect: true,
     padding: .medium,
     style: .plain,
     unfocusedOpacity: 0.0)
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
