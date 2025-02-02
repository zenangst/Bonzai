import SwiftUI

public struct TextDefaults {
  public var color: Color
  public var font: Font

  init(color: Color = .primary, font: Font = .body) {
    self.color = color
    self.font = font
  }
}
