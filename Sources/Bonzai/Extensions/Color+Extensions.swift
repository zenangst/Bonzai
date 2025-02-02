import SwiftUI

public extension Color {
  static var systemGreen: Color { .init(NSColor.systemGreen) }
  static var systemBlue: Color { .init(NSColor.systemBlue) }
  static var systemRed: Color { .init(NSColor.systemRed) }
  static var systemYellow: Color { .init(NSColor.systemYellow) }
  static var systemOrange: Color { .init(NSColor.systemOrange) }
  static var systemIndigo: Color { .init(NSColor.systemIndigo) }
  static var systemPurple: Color { .init(NSColor.systemPurple) }
  static var systemPink: Color { .init(NSColor.systemPink) }
  static var systemTeal: Color { .init(NSColor.systemTeal) }
  static var systemGray: Color { .init(NSColor.systemGray) }

  static var label: Color { .init(NSColor.labelColor) }
  static var secondaryLabel: Color { .init(NSColor.secondaryLabelColor) }
  static var tertiaryLabel: Color { .init(NSColor.tertiaryLabelColor) }
  static var quaternaryLabel: Color { .init(NSColor.quaternaryLabelColor) }

  static var placeholderText: Color { .init(NSColor.placeholderTextColor) }
  static var separator: Color { .init(NSColor.separatorColor) }

  static var link: Color { .init(NSColor.linkColor) }
  static var accent: Color { .init(NSColor.controlAccentColor) }

  static var systemBackground: Color { .init(NSColor.windowBackgroundColor) }
  static var secondarySystemBackground: Color { .init(NSColor.controlBackgroundColor) }
  static var tertiarySystemBackground: Color { .init(NSColor.textBackgroundColor) }

  static var groupTableViewBackground: Color { .init(NSColor.controlBackgroundColor) }

  static var text: Color { .init(NSColor.textColor) }
  static var secondaryText: Color { .init(NSColor.secondaryLabelColor) }
  static var disabledText: Color { .init(NSColor.disabledControlTextColor) }

  static var lightText: Color { .init(NSColor.alternateSelectedControlTextColor) }
  static var darkText: Color { .init(NSColor.selectedTextColor) }
}

extension Color {
  var nsBackgroundColor: NSColor {
    if let cgColor = cgColor, let nsColor = NSColor(cgColor: cgColor) {
      return nsColor
    }

    switch self {
    case .primary:
      return NSColor.textBackgroundColor
    case .secondary:
      return NSColor.secondaryLabelColor
    default:
      return .controlAccentColor
    }
  }

  var nsForegroundColor: NSColor {
    if let cgColor = cgColor, let nsColor = NSColor(cgColor: cgColor) {
      return nsColor
    }

    switch self {
    case .primary:
      return NSColor.textColor
    case .secondary:
      return NSColor.secondaryLabelColor
    default:
      return .controlAccentColor
    }
  }

  func blended(withFraction fraction: Double, of blendColor: Color) -> Color {
    let blendedRed = components.red * (1.0 - fraction) + blendColor.components.red * fraction
    let blendedGreen = components.green * (1.0 - fraction) + blendColor.components.green * fraction
    let blendedBlue = components.blue * (1.0 - fraction) + blendColor.components.blue * fraction
    return Color(red: blendedRed, green: blendedGreen, blue: blendedBlue, opacity: 1.0)
  }}

