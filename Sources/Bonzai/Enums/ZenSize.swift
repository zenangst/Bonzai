import Foundation

public enum ZenSize {
  case small
  case medium
  case large

  var padding: CGFloat {
    switch self {
    case .small:
      return 2
    case .medium:
      return 4
    case .large:
      return 6
    }
  }
}
