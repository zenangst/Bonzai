import SwiftUI

struct ZenRoundedContainer: ViewModifier {
  private let cornerRadius: CGFloat
  private let padding: CGFloat

  init(cornerRadius: CGFloat, padding: CGFloat) {
    self.cornerRadius = cornerRadius
    self.padding = padding
  }

  func body(content: Content) -> some View {
    content
      .background(Color(nsColor: .underPageBackgroundColor))
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(Color(nsColor: .controlColor), lineWidth: 1)
      )
      .padding(padding)
  }
}

public extension View {
  func roundedContainer(_ cornerRadius: CGFloat = 8, padding: CGFloat = 16) -> some View {
    self
      .modifier(ZenRoundedContainer(cornerRadius: cornerRadius, padding: padding))
  }
}
