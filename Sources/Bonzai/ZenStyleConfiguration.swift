import Cocoa
import SwiftUI

public struct ZenStyleConfiguration {
  let calm: Bool
  let color: ZenColor
  let backgroundColor: Color
  let cornerRadius: CGFloat
  let font: Font
  let glow: Bool
  let padding: Padding
  let unfocusedOpacity: CGFloat

  let focusEffect: Binding<Bool>
  var grayscaleEffect: Binding<Bool>
  var hoverEffect: Binding<Bool>

  public struct Padding {
    let horizontal: ZenSize
    let vertical: ZenSize?

    public init(horizontal: ZenSize, vertical: ZenSize?) {
      self.horizontal = horizontal
      self.vertical = vertical
    }

    public init(_ size: ZenSize) {
        self.horizontal = size
        self.vertical = size
    }

    static public var large: Padding { Padding(horizontal: .large, vertical: .large) }
    static public var medium: Padding { Padding(horizontal: .medium, vertical: .medium) }
    static public var small: Padding { Padding(horizontal: .small, vertical: .small) }
    static public var zero: Padding { Padding(horizontal: .zero, vertical: .zero) }
  }

  public init(calm: Bool = false,
              color: ZenColor = .accentColor,
              backgroundColor: Color = Color(nsColor: .textBackgroundColor),
              cornerRadius: CGFloat = 4,
              font: Font = .body,
              glow: Bool = false,
              focusEffect: Binding<Bool> = .constant(false),
              grayscaleEffect: Binding<Bool> = .constant(false),
              hoverEffect: Binding<Bool> = .constant(true),
              padding: Padding = .init(horizontal: .medium, vertical: .medium),
              unfocusedOpacity: CGFloat = 0.1) {
    self.backgroundColor = backgroundColor
    self.calm = calm
    self.color = color
    self.cornerRadius = cornerRadius
    self.font = font
    self.focusEffect = focusEffect
    self.grayscaleEffect = grayscaleEffect
    self.glow = glow
    self.hoverEffect = hoverEffect
    self.padding = padding
    self.unfocusedOpacity = unfocusedOpacity
  }
}
