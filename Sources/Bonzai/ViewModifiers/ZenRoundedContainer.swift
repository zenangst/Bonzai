import SwiftUI

struct ZenRoundedContainer: ViewModifier {
  @Environment(\.colorScheme) var colorScheme
  private let cornerRadius: CGFloat
  private let padding: CGFloat
  private let margin: CGFloat

  init(cornerRadius: CGFloat, padding: CGFloat, margin: CGFloat) {
    self.cornerRadius = cornerRadius
    self.padding = padding
    self.margin = margin
  }

  func body(content: Content) -> some View {
    content
      .padding(padding)
      .background(background())
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(Color(nsColor: .controlColor).opacity(0.2), lineWidth: 3)
      )
      .background(
        RoundedRectangle(cornerRadius: cornerRadius + 1)
          .stroke(borderColor(), lineWidth: 1)
          .padding(-1)
      )
      .compositingGroup()
      .shadow(color: shadowColor(), radius: 2, y: 2)
      .padding(margin)
  }

  private func borderColor() -> Color {
    colorScheme == .dark
    ? Color(nsColor: .controlColor).opacity(0.4)
    : Color(nsColor: .systemGray).opacity(0.2)

  }

  private func background() -> Color? {
    colorScheme == .dark
    ? Color(nsColor: .underPageBackgroundColor)
    : Color(nsColor: .alternateSelectedControlTextColor)
  }

  private func shadowColor() -> Color {
    colorScheme == .dark
      ? Color(.sRGBLinear, white: 0, opacity: 0.4)
      : Color(.sRGBLinear, white: 0, opacity: 0.1)
  }
}

public extension View {
  func roundedContainer(_ cornerRadius: CGFloat = 8, padding: CGFloat = 16, margin: CGFloat = 16) -> some View {
    self
      .modifier(ZenRoundedContainer(cornerRadius: cornerRadius, padding: padding, margin: margin))
  }
}

#Preview {
    VStack {
       Text("Light Mode")
            .roundedContainer()
            .environment(\.colorScheme, .light)

        Text("Dark Mode")
            .roundedContainer()
            .environment(\.colorScheme, .dark)
    }
}
