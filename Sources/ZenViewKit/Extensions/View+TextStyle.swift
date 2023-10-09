import SwiftUI

public enum ZenTextVariant {
  case regular
  case zen
}

public extension Text {
  func textStyle(_ variant: ZenTextVariant) -> some View {
    return self.modifier(ZenTextViewModifier())
  }

  private func resolve(_ variant: ZenTextFieldVariant) -> some TextFieldStyle {
    ZenTextFieldStyle()
  }
}
