import Cocoa
import SwiftUI

public struct ZenStyleConfiguration {
  let cornerRadius: CGFloat
  let color: ZenColor
  let padding: Padding
  let calm: Bool

  var grayscaleEffect: Binding<Bool>
  var hoverEffect: Binding<Bool>

  public struct Padding {
    let horizontal: ZenSize
    let vertical: ZenSize?

    public init(horizontal: ZenSize, vertical: ZenSize?) {
      self.horizontal = horizontal
      self.vertical = vertical
    }
  }

  public init(color: ZenColor,
              cornerRadius: CGFloat = 4,
              padding: Padding = .init(horizontal: .medium, vertical: .medium),
              calm: Bool = false,
              grayscaleEffect: Binding<Bool> = .constant(false),
              hoverEffect: Binding<Bool> = .constant(true)) {
    self.color = color
    self.cornerRadius = cornerRadius
    self.padding = padding
    self.calm = calm
    self.grayscaleEffect = grayscaleEffect
    self.hoverEffect = hoverEffect
  }
}
