import Cocoa

public struct ZenStyleConfiguration {
  let cornerRadius: CGFloat
  let color: ZenColor
  let padding: Padding
  let grayscaleEffect: Bool
  let calm: Bool
  let hoverEffect: Bool

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
              grayscaleEffect: Bool = false,
              hoverEffect: Bool = true) {
    self.color = color
    self.cornerRadius = cornerRadius
    self.padding = padding
    self.calm = calm
    self.grayscaleEffect = grayscaleEffect
    self.hoverEffect = hoverEffect
  }
}
