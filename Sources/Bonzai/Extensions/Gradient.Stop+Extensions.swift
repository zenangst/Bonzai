import SwiftUI

extension Gradient.Stop {
  static func zen(_ colorScheme: ColorScheme,
                  isHovered: Bool,
                  color: Color) -> [Gradient.Stop] {
    if colorScheme == .dark {
      return [
        .init(color: color, location: 0.0),
        .init(color: color.blended(withFraction: 0.3, of: .black), location: 0.025),
        .init(color: color.blended(withFraction: 0.5, of: .black), location: 1.0),
      ]
    } else {
      return [
        .init(color: color.blended(withFraction: 0.8, of: .white), location: 0.0),
        .init(color: color.blended(withFraction: isHovered ? 0.1 : 0.6, of: .white), location: 0.05),
        .init(color: color.blended(withFraction: isHovered ? 0.4 : 0.2, of: isHovered ? .black : .white), location: 1.0),
      ]
    }
  }
}

extension Color {
  var components: (red: Double, green: Double, blue: Double, opacity: Double) {
    let nsColor: NSColor?

    if #available(macOS 12.0, *) {
      nsColor = NSColor(self)
    } else {
      nsColor = NSColor(cgColor: self.cgColor ?? .clear)
    }

    guard let resolvedColor = nsColor?.usingColorSpace(.deviceRGB) else {
      return (0, 0, 0, 1)
    }

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    resolvedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return (Double(red), Double(green), Double(blue), Double(alpha))
  }
}
