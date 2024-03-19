import Cocoa
import SwiftUI

extension Gradient.Stop {
  static func zen(_ colorScheme: ColorScheme, 
                  isHovered: Bool,
                  nsColor: NSColor) -> [Gradient.Stop] {
    if colorScheme == .dark {
      [
        .init(color: Color(nsColor), location: 0.0),
        .init(color: Color(nsColor.blended(withFraction: 0.3, of: .black)!), location: 0.025),
        .init(color: Color(nsColor.blended(withFraction: 0.5, of: .black)!), location: 1.0),
      ]
    } else {
      [
        .init(color: Color(nsColor.blended(withFraction: 0.8, of: .white)!), location: 0.0),
        .init(color: Color(nsColor.blended(withFraction: isHovered ? 0.1 : 0.6,
                                           of: isHovered ? .white : .white)!), location: 0.05),
        .init(color: Color(nsColor.blended(withFraction: isHovered ? 0.4 : 0.2,
                                           of: isHovered ? .black : .white)!), location: 1.0),
      ]
    }
  }
}
