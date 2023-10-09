import SwiftUI

public enum ZenTextFieldVariant {
  case regular
  case zen(Font, CGFloat, ZenColor)
}

public extension View {
  func textFieldStyle(_ variant: ZenTextFieldVariant) -> some View {
    let textFieldStyle = resolve(variant)
    return self.textFieldStyle(textFieldStyle)
  }

  private func resolve(_ variant: ZenTextFieldVariant) -> some TextFieldStyle {
    switch variant {
    case .regular:
      ZenTextFieldStyle()
    case .zen(let font, let unfocusedOpacity, let color):
      ZenTextFieldStyle(
        font,
        unfocusedOpacity: unfocusedOpacity,
        color: color
      )
    }
  }
}
