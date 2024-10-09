import Foundation

public enum ZenSize {
  case small
  case medium
  case large
  case extraLarge
  case zero

  var padding: CGFloat {
    switch self {
    case .small: 2
    case .medium: 4
    case .large: 6
    case .extraLarge: 8
    case .zero: 0
    }
  }
}
