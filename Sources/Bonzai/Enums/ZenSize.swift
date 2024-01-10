import Foundation

public enum ZenSize {
  case small
  case medium
  case large
  case zero

  var padding: CGFloat {
    switch self {
    case .small: 2
    case .medium: 4
    case .large: 6
    case .zero: 0
    }
  }
}
