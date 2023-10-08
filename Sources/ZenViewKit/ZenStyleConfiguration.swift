import Cocoa

public struct ZenStyleConfiguration {
  let cornerRadius: CGFloat
  let nsColor: NSColor
  let padding: Padding
  let grayscaleEffect: Bool
  let calm: Bool
  let hoverEffect: Bool

  public struct Padding {
    let horizontal: CGFloat
    let vertical: CGFloat?

    init(horizontal: CGFloat, vertical: CGFloat?) {
      self.horizontal = horizontal
      self.vertical = vertical
    }
  }

  internal init(nsColor: NSColor, 
                cornerRadius: CGFloat = 4,
                padding: Padding = .init(horizontal: 4, vertical: 4),
                calm: Bool = false,
                grayscaleEffect: Bool = false,
                hoverEffect: Bool = true) {
    self.nsColor = nsColor
    self.cornerRadius = cornerRadius
    self.padding = padding
    self.calm = calm
    self.grayscaleEffect = grayscaleEffect
    self.hoverEffect = hoverEffect
  }
}
