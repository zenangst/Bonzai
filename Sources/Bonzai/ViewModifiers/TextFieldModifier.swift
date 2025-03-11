import SwiftUI

struct TextFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .textFieldStyle(ZenTextFieldStyle())
  }
}

extension View {
  func textFieldStyle() -> some View {
    self.modifier(TextFieldModifier())
  }
}
