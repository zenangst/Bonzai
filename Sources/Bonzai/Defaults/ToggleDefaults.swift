import SwiftUI

public struct ToggleDefaults {
  public enum Style {
    case regular
    case small

    var size: CGSize {
      switch self {
      case .regular:
        return CGSize(width: 14, height: 14)
      case .small:
        return CGSize(width: 12, height: 12)
      }
    }

    var fontSize: CGFloat {
      switch self {
      case .regular:
        return 10
      case .small:
        return 8
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
  public var padding: ToggleDefaults.Padding
  public var unfocusedOpacity: Double
  public var style: Style

  init(backgroundColor: Color = Color.systemGreen,
       calm: Bool = false,
       cornerRadius: CGFloat = 4,
       focusEffect: Bool = false,
       font: Font = .body,
       foregroundColor: Color = Color.white,
       glow: Bool = false,
       grayscaleEffect: Bool = false,
       hoverEffect: Bool = true,
       padding: ToggleDefaults.Padding = .small,
       style: Style = .regular,
       unfocusedOpacity: Double = 0.1) {
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
}

public struct ToggleOverrides {
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
  public var padding: ToggleDefaults.Padding?
  public var style: ToggleDefaults.Style?
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
    padding: ToggleDefaults.Padding? = nil,
    style: ToggleDefaults.Style? = nil,
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
