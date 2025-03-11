import SwiftUI

struct CheckboxModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .toggleStyle(ZenCheckboxStyle())
  }
}

public extension View {
  func checkboxStyle() -> some View {
    self.modifier(CheckboxModifier())
  }
}
