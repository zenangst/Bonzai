import SwiftUI

struct StyledMenuModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.menuStyle(ZenMenuStyle())
  }
}

public extension View {
  func menuStyle() -> some View {
    self.modifier(StyledMenuModifier())
  }
}
