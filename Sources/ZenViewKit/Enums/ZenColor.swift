import AppKit

public enum ZenColor {
  case accentColor
  case black
  case systemRed
  case systemOrange
  case systemYellow
  case systemGreen
  case systemBlue
  case systemBrown
  case systemPurple
  case systemGray
  case systemCyan
  case systemMint
  case systemTeal
  case systemIndigo

  public var nsColor: NSColor {
    switch self {
    case .accentColor:
      NSColor.controlAccentColor
    case .black:
      NSColor.black
    case .systemRed:
      NSColor.systemRed
    case .systemOrange:
      NSColor.systemOrange
    case .systemYellow:
      NSColor.systemYellow
    case .systemGreen:
      NSColor.systemGreen
    case .systemBlue:
      NSColor.systemBlue
    case .systemBrown:
      NSColor.systemBrown
    case .systemPurple:
      NSColor.systemPurple
    case .systemGray:
      NSColor.systemGray
    case .systemCyan:
      NSColor.systemCyan
    case .systemMint:
      NSColor.systemMint
    case .systemTeal:
      NSColor.systemTeal
    case .systemIndigo:
      NSColor.systemIndigo
    }

  }
}
